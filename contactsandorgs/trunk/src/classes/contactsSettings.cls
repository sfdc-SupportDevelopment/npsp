public with sharing class contactsSettings {
    
    public Contacts_and_Orgs_Settings__c settingsToUpdate;
    public Contacts_and_Orgs_Settings__c pageSettings = new Contacts_and_Orgs_Settings__c();
    
    public contactsSettings(){
        
    }
    
    public Contacts_and_Orgs_Settings__c getSettings() {
        pageSettings = Constants.getContactsSettings();
        return pageSettings;
    }
    //we can't do a DML in a getter, so I call it from the action of the page
    public PageReference getSettingsFirstTime() {
        pageSettings = Constants.getContactsSettings();
        return null;
    }
    
    public List<SelectOption> getcontactRoles() {
    
        if(contactRoles.size()==0){
            contactRoles.add(new SelectOption(' ','- none -'));
            Schema.DescribeFieldResult F = Schema.sObjectType.OpportunityContactRole.fields.Role; 
            List<Schema.PicklistEntry> P = F.getPicklistValues();
            for(Schema.PicklistEntry pe : P){
                contactRoles.add(new SelectOption(pe.getLabel(), pe.getLabel()));
            }
        }
        return contactRoles;
    }
    
    List<SelectOption> accountmodels;
   
    List<SelectOption> contactRoles = new List<SelectOption>();

    public List<SelectOption> getaccountmodels() {
        if(accountmodels == null){
            accountmodels = new List<SelectOption>();
            accountmodels.add(new SelectOption('One-to-One', 'One-to-One'));
            accountmodels.add(new SelectOption('Individual', 'Individual'));
        }
        return accountmodels;
    }
    
    
    private void showInfoMsg(String arg){
        ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.INFO,arg);
        ApexPages.addMessage(myMsg);
    }
    
    public void updateSettings(){
        
        update pageSettings;
        showInfoMsg('Contacts and Organizations Settings updated');
    }
    
     public static testMethod void TEST_contactSettings() {
        
        Test.setCurrentPageReference(new PageReference('Page.contactSettings'));
        
        //pass the controller into the extension
        contactsSettings controller = new contactsSettings(); 
        controller.getSettingsFirstTime();
        system.assertNotEquals(null,controller.getSettings());
        
        List<SelectOption> accountModels =  controller.getaccountmodels(); 
        system.assertEquals(2,accountModels.size());
        
        List<SelectOption> conRoles = controller.getcontactRoles();
        system.assertNotEquals(null,conRoles);
        controller.updateSettings();
        
    }

}