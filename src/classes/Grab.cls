public with sharing class Grab
{
    public static Object grab( String field, sObject obj )
    {
        return obj.get( field );
    }

    public static Set<Object> grab( String field, List<sObject> objs )
    {
        Set<Object> grabbed = new Set<Object>();

        for ( sObject obj : objs )
        {
            Object value = grab( field, obj );
            if ( value != null )
            {
                grabbed.add( value );
            }
        }

        return grabbed;
    }

    public static Object grab( Schema.SObjectField field, sObject obj )
    {
        return obj.get( field );
    }

    public static Set<Object> grab( Schema.SObjectField field, List<sObject> objs )
    {
        Set<Object> grabbed = new Set<Object>();

        for ( sObject obj : objs )
        {
            Object value = grab( field, obj );
            if ( value != null )
            {
                grabbed.add( value );
            }
        }

        return grabbed;
    }

    public static Id grabId( String field, sObject obj )
    {
        return (Id)grab( field, obj );
    }

    public static Id grabId( Schema.SObjectField idField, sObject obj )
    {
        return (Id)grab( idField, obj );
    }

    public static Set<Id> ids( List<sObject> objs )
    {
        Map<Id, sObject> objectMap = new Map<Id, sObject>();
        objectMap.putAll( objs );
        return objectMap.keySet().clone();
    }

    public static Set<Id> ids( String field, List<sObject> objs )
    {
        Set<Id> grabbed = new Set<Id>();

        for ( sObject obj : objs )
        {
            Id recordId = grabId( field, obj );
            if ( recordId != null )
            {
                grabbed.add( recordId );
            }
        }

        return grabbed;
    }

    public static Set<Id> ids( Schema.SObjectField idField, List<sObject> objs )
    {
        Set<Id> grabbed = new Set<Id>();

        for ( sObject obj : objs )
        {
            Id recordId = grabId( idField, obj );
            if ( recordId != null )
            {
                grabbed.add( recordId );
            }
        }

        return grabbed;
    }

    public static String grabString( String field, sObject obj )
    {
        return (String)grab( field, obj );
    }

    public static Set<String> strings( String field, List<sObject> objs )
    {
        Set<String> grabbed = new Set<String>();

        for ( sObject obj : objs )
        {
            String stringValue = grabString( field, obj );
            if ( stringValue != null )
            {
                grabbed.add( stringValue );
            }
        }

        return grabbed;
    }

    public static String grabString( Schema.SObjectField stringField, sObject obj )
    {
        return (String)grab( stringField, obj );
    }

    public static Set<String> strings( Schema.SObjectField stringField, List<sObject> objs )
    {
        Set<String> grabbed = new Set<String>();

        for ( sObject obj : objs )
        {
            String stringValue = grabString( stringField, obj );
            if ( stringValue != null )
            {
                grabbed.add( stringValue );
            }
        }

        return grabbed;
    }
}