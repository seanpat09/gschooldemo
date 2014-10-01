@isTest
private class GrabTest
{
    private static testMethod void grabTest()
    {
        Lead fry = new Lead( FirstName = 'Fry', LastName = 'Five', Company = 'Fry Co' );

        Test.startTest();
            Object actualName = Grab.grab( 'FirstName', fry );
        Test.stopTest();

        System.assertEquals( fry.FirstName, actualName, 'The sObject Name should be returned in a set' );
    }

    private static testMethod void grabIgnoresNulls()
    {
        Lead fry = new Lead();

        Test.startTest();
            Set<Object> actualIds = Grab.grab( 'Id', new List<sObject>{ fry } );
        Test.stopTest();

        System.assert( actualIds.isEmpty(), 'null values should be ignored' );
    }

    private static testMethod void grabBulkTest()
    {
        Lead fry = new Lead( FirstName = 'Fry', LastName = 'Five', Company = 'Fry Co' );
        Lead leela  = new Lead( FirstName = 'Leela', LastName = 'Five', Company = 'Leela Co' );
        Lead bender = new Lead( FirstName = 'Bender', LastName = 'Five', Company = 'Bender Co' );

        List<Lead> allLeads = new List<Lead>{ fry, leela, bender };

        Test.startTest();
            Set<Object> actualNames = Grab.grab( 'FirstName', allLeads );
        Test.stopTest();

        System.assert( actualNames.contains( fry.FirstName ), 'The FirstNames of the records should be returned in a set' );
        System.assert( actualNames.contains( leela.FirstName ), 'The FirstNames of the records should be returned in a set' );
        System.assert( actualNames.contains( bender.FirstName ), 'The FirstNames of the records should be returned in a set' );
    }
    private static testMethod void grabIdTest()
    {
        Lead fry = new Lead( Id = '00Q0000000XXXXX', FirstName = 'Fry', LastName = 'Five', Company = 'Fry Co' );

        Test.startTest();
            Id actualId = Grab.grabId( 'Id', fry );
        Test.stopTest();

        System.assertEquals( fry.Id, actualId, 'The sObject id should be returned in a set' );
    }

    private static testMethod void grabIdsIgnoresNulls()
    {
        Lead fry = new Lead();

        Test.startTest();
            Set<Id> actualIds = Grab.ids( 'Id', new List<sObject>{ fry } );
        Test.stopTest();

        System.assert( actualIds.isEmpty(), 'null values should be ignored' );
    }

    private static testMethod void grabIdsTest()
    {
        Lead fry = new Lead( Id = '00Q0000000XXXX1', FirstName = 'Fry', LastName = 'Five', Company = 'Fry Co' );
        Lead leela  = new Lead( Id = '00Q0000000XXXX2', FirstName = 'Leela', LastName = 'Five', Company = 'Leela Co' );
        Lead bender = new Lead( Id = '00Q0000000XXXX3', FirstName = 'Bender', LastName = 'Five', Company = 'Bender Co' );

        List<Lead> allLeads = new List<Lead>{ fry, leela, bender };
        Map<Id, Lead> allLeadsMap = new Map<Id, Lead>{
            '00Q0000000XXXXX' => fry,
            '00Q0000000XXXXY' => leela,
            '00Q0000000XXXXZ' => bender
        };

        Test.startTest();
            Set<Id> actualIdsList = Grab.ids( 'Id', allLeads );
        Test.stopTest();

        System.assert( actualIdsList.contains( fry.Id ), 'The Ids of the records should be returned in a set' );
        System.assert( actualIdsList.contains( leela.Id ), 'The Ids of the records should be returned in a set' );
        System.assert( actualIdsList.contains( bender.Id ), 'The Ids of the records should be returned in a set' );
    }

    private static testMethod void grabIdsTest_SchemaField()
    {
        Lead fry = new Lead( Id = '00Q0000000XXXX1', FirstName = 'Fry', LastName = 'Five', Company = 'Fry Co' );
        Lead leela  = new Lead( Id = '00Q0000000XXXX2', FirstName = 'Leela', LastName = 'Five', Company = 'Leela Co' );
        Lead bender = new Lead( Id = '00Q0000000XXXX3', FirstName = 'Bender', LastName = 'Five', Company = 'Bender Co' );

        List<Lead> allLeads = new List<Lead>{ fry, leela, bender };
        Map<Id, Lead> allLeadsMap = new Map<Id, Lead>{
            '00Q0000000XXXXX' => fry,
            '00Q0000000XXXXY' => leela,
            '00Q0000000XXXXZ' => bender
        };

        Test.startTest();
            Set<Id> actualIdsList = Grab.ids( Lead.Id, allLeads );
        Test.stopTest();

        System.assert( actualIdsList.contains( fry.Id ), 'The Ids of the records should be returned in a set' );
        System.assert( actualIdsList.contains( leela.Id ), 'The Ids of the records should be returned in a set' );
        System.assert( actualIdsList.contains( bender.Id ), 'The Ids of the records should be returned in a set' );
    }

    private static testMethod void grabIdsModifySetTest()
    {
        Lead leela  = new Lead( Id = '00Q0000000XXXX2', FirstName = 'Leela', LastName = 'Five', Company = 'Leela Co' );
        Lead bender = new Lead( Id = '00Q0000000XXXX3', FirstName = 'Bender', LastName = 'Five', Company = 'Bender Co' );

        List<Lead> allLeads = new List<Lead>{  leela };

        Test.startTest();
            Set<Id> idsList = Grab.ids( allLeads );


            idsList.add(bender.Id);
        Test.stopTest();

        System.assertEquals( 2, idsList.size(), 'The Set returned from grab.ids should be modifiable');
    }

    private static testMethod void grabIdsAssumeIdField()
    {
        Lead bender = new Lead( Id = '00Q0000000XXXX3', FirstName = 'Bender', LastName = 'Five', Company = 'Bender Co' );

        List<Lead> allLeadsList = new List<Lead>{ bender };
        Map<Id, Lead> allLeadsMap = new Map<Id, Lead>{ '00Q0000000XXXXX' => bender };

        Test.startTest();
            Set<Id> actualIdsList = Grab.ids( allLeadsList );
        Test.stopTest();

        System.assert( actualIdsList.contains( bender.Id ), 'The Ids of the records should be returned in a set from the list' );
    }

    private static testMethod void grabIdsAssumeIdField_Duplicates()
    {
        final Id DUMMY_LEAD_ID = '00Q0000000XXXX3';
        Lead bender = new Lead( Id = DUMMY_LEAD_ID, FirstName = 'Bender', LastName = 'Five', Company = 'Bender Co' );
        Lead benderDupe = new Lead( Id = DUMMY_LEAD_ID, FirstName = 'Bender', LastName = 'Five', Company = 'Bender Co' );

        List<Lead> allLeadsList = new List<Lead>{ bender, benderDupe };

        ListException unexpectedListEx;
        Set<Id> actualIds;
        Test.startTest();
            try
            {
                actualIds = Grab.ids( allLeadsList );
            }
            catch( ListException listEx )
            {
                unexpectedListEx = listEx;
            }
        Test.stopTest();
        System.assertEquals( null, unexpectedListEx, 'There should be no list exception' );
        System.assert( actualIds.contains( bender.Id ), 'The Ids of the records should be returned in a set from the list' );
    }

    private static testMethod void grabStringTest()
    {
        Lead fry = new Lead( FirstName = 'Fry', LastName = 'Five', Company = 'Fry Co' );

        Test.startTest();
            String actualName = Grab.grabString( 'FirstName', fry );
        Test.stopTest();

        System.assertEquals( fry.FirstName, actualName, 'The sObject Name should be returned in a set' );
    }

    private static testMethod void grabStringsIgnoresNulls()
    {
        Lead fry = new Lead();

        Test.startTest();
            Set<String> actualStrings = Grab.strings( 'FirstName', new List<sObject>{ fry } );
        Test.stopTest();

        System.assert( actualStrings.isEmpty(), 'null values should be ignored' );
    }

    private static testMethod void grabStringsTest()
    {
        Lead fry = new Lead( FirstName = 'Fry', LastName = 'Five', Company = 'Fry Co' );
        Lead leela  = new Lead( FirstName = 'Leela', LastName = 'Five', Company = 'Leela Co' );
        Lead bender = new Lead( FirstName = 'Bender', LastName = 'Five', Company = 'Bender Co' );

        List<Lead> allLeads = new List<Lead>{ fry, leela, bender };
        Map<Id, Lead> allLeadsMap = new Map<Id, Lead>{
            '00Q0000000XXXXX' => fry,
            '00Q0000000XXXXY' => leela,
            '00Q0000000XXXXZ' => bender
        };

        Test.startTest();
            Set<String> actualNamesList = Grab.strings( 'FirstName', allLeads );
        Test.stopTest();

        System.assert( actualNamesList.contains( fry.FirstName ), 'The FirstNames of the records should be returned in a set' );
        System.assert( actualNamesList.contains( leela.FirstName ), 'The FirstNames of the records should be returned in a set' );
        System.assert( actualNamesList.contains( bender.FirstName ), 'The FirstNames of the records should be returned in a set' );
    }

    private static testMethod void grabStringTest_SchemaField()
    {
        Lead fry = new Lead( FirstName = 'Fry', LastName = 'Five', Company = 'Fry Co' );

        Test.startTest();
            String actualName = Grab.grabString( Lead.FirstName, fry );
        Test.stopTest();

        System.assertEquals( fry.FirstName, actualName, 'The sObject Name should be returned in a set' );
    }

    private static testMethod void grabStringsIgnoresNulls_SchemaField()
    {
        Lead fry = new Lead();

        Test.startTest();
            Set<String> actualStrings = Grab.strings( Lead.FirstName, new List<sObject>{ fry } );
        Test.stopTest();

        System.assert( actualStrings.isEmpty(), 'null values should be ignored' );
    }

    private static testMethod void grabStringsTest_SchemaField()
    {
        Lead fry = new Lead( FirstName = 'Fry', LastName = 'Five', Company = 'Fry Co' );
        Lead leela  = new Lead( FirstName = 'Leela', LastName = 'Five', Company = 'Leela Co' );
        Lead bender = new Lead( FirstName = 'Bender', LastName = 'Five', Company = 'Bender Co' );

        List<Lead> allLeads = new List<Lead>{ fry, leela, bender };
        Map<Id, Lead> allLeadsMap = new Map<Id, Lead>{
            '00Q0000000XXXXX' => fry,
            '00Q0000000XXXXY' => leela,
            '00Q0000000XXXXZ' => bender
        };

        Test.startTest();
            Set<String> actualNamesList = Grab.strings( Lead.FirstName, allLeads );
        Test.stopTest();

        System.assert( actualNamesList.contains( fry.FirstName ), 'The FirstNames of the records should be returned in a set' );
        System.assert( actualNamesList.contains( leela.FirstName ), 'The FirstNames of the records should be returned in a set' );
        System.assert( actualNamesList.contains( bender.FirstName ), 'The FirstNames of the records should be returned in a set' );
    }
}
