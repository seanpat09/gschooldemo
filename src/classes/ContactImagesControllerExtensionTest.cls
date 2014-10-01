@isTest
private class ContactImagesControllerExtensionTest
{
    static Contact buildAndInsertContact()
    {
        Contact testContact = new Contact( LastName = 'Wayne' );
        insert testContact;
        return testContact;
    }

    static List<Attachment> buildAndInsertAttachments( Integer numOfAttachments, Id parentId, String contentType )
    {
        Blob testBody = Blob.valueOf('anAttachment');
        List<Attachment> testAttachments = new List<Attachment>();
        for( Integer i = 0; i < numOfAttachments; i++ )
        {
            testAttachments.add( new Attachment( Name = 'test'+i+'.ext',
                                                 ParentId = parentId,
                                                 Body = testBody,
                                                 ContentType = contentType ) );
        }
        insert testAttachments;
        return testAttachments;
    }

    static testMethod void constructor()
    {
        Contact testContact = buildAndInsertContact();
        ApexPages.StandardController standCont = new ApexPages.StandardController(testContact);
        Test.startTest();
             ContactImagesControllerExtension ext = new ContactImagesControllerExtension(standCont);
        Test.stopTest();

        System.assertEquals( testContact.Id, ext.recordId, 'The extension should have the correct record Id' );
    }

    static testMethod void getImageIdsForContact()
    {
        final Integer NUM_ATTACHMENTS = 5;
        Contact testContact = buildAndInsertContact();
        List<Attachment> images = buildAndInsertAttachments( NUM_ATTACHMENTS, testContact.Id, 'image' );
        List<Attachment> documents = buildAndInsertAttachments( NUM_ATTACHMENTS, testContact.Id, 'doc' );
        
        ApexPages.StandardController standCont = new ApexPages.StandardController(testContact);
        ContactImagesControllerExtension ext = new ContactImagesControllerExtension(standCont);
        Test.startTest();
            List<Id> attachmentIds = ext.getImageIdsForContact();
        Test.stopTest();

        System.assertEquals( NUM_ATTACHMENTS, attachmentIds.size(), 
            'The correct number of ids should have been returned' );
        System.assertEquals( Grab.ids(images), new Set<Id>(attachmentIds),
            'All of and only the image attachment id should have been returned' );
    }
}