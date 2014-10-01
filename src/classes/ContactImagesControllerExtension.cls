public with sharing class ContactImagesControllerExtension
{
    @TestVisible private Id recordId;

    public ContactImagesControllerExtension(ApexPages.StandardController stdController)
    {
        this.recordId = stdController.getId();
    }

    public List<Id> getImageIdsForContact()
    {
        List<Id> imageIds = new List<Id>();
        for( Attachment anAttachment : [ SELECT Id 
                                         FROM Attachment 
                                         WHERE ContentType LIKE '%image%'
                                            AND ParentId = :recordId ] )
        {
            imageIds.add( anAttachment.Id );
        }
        return imageIds;
    }
}