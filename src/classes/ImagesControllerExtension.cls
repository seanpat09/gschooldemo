public with sharing class ImagesControllerExtension
{
    @TestVisible private Id recordId;

    public ImagesControllerExtension(ApexPages.StandardController standController)
    {
        this.recordId = standController.getId();
    }

    public List<Id> getImageIdsForRecord()
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