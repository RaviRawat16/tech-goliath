                    //To make sure not more than three Owners can be assigned 
                    //to same Zip Code and if someone tries to assign more than three owners
                    //give an error


                    public class TerritoryCustomObjectClass {


                        // method for territory insert trigger
                        public static void territoryInsert(List<Territory__c> triggerNew){
                            map<String,integer> uniqueReps = new map<String,integer>(); // map for ZipCodes and there unique Owner Count
                            
                            // AggregateResult function to get List of ZipCodes and Count of owners
                            List <AggregateResult> zipCodeOwner = [Select Zip_Code__c , Count(Owner__c)owncount from Territory__c Group By Zip_Code__c];
                            
                            for(AggregateResult uniqueOwner : zipCodeOwner){   		// map values directly from AggregateResult function
                                
                                uniqueReps.put(string.valueof(uniqueOwner.get('Zip_Code__c')) , integer.valueof(uniqueOwner.get('owncount')));
                            }
                            
                            // Run Trigger for before Insert/Update to make sure not more than three users for one zip
                            for(Territory__c terriTrig : triggerNew){
                                if(uniqueReps.get(terriTrig.Zip_Code__c)==3 && uniqueReps.containskey(terriTrig.Zip_Code__c)){
                                    terriTrig.addError('A single Zip cannot be assigned to more than three sales rep');
                                }
                            }    
                        }
                            
                        // Method for territory update trigger
                        public static void territoryUpdate(List<Territory__c>triggerNew ,  map<Id,Territory__c>triggerOld){
                            
                            map<String,integer> uniqueReps = new map<String,integer>(); // map for ZipCodes and there unique Owner Count
                            
                            // AggregateResult function to get List of ZipCodes and Count of owners
                            List <AggregateResult> zipCodeOwner = [Select Zip_Code__c , Count(Owner__c)owncount from Territory__c Group By Zip_Code__c];
                            
                            for(AggregateResult uniqueOwner : zipCodeOwner){   		// map values directly from AggregateResult function
                                
                                uniqueReps.put(string.valueof(uniqueOwner.get('Zip_Code__c')) , integer.valueof(uniqueOwner.get('owncount')));
                            }
                            
                            for(Territory__c terriTrig : triggerNew){
                                        //check if someone is trying to change the ZipCode to assign owner new Zip
                                if(terriTrig.Zip_Code__c != triggerOld.get(terriTrig.Id).Zip_Code__c){
                                    if(uniqueReps.get(terriTrig.Zip_Code__c)==3 && uniqueReps.containskey(terriTrig.Zip_Code__c)){
                                        terriTrig.addError('A single Zip cannot be assigned to more than three sales rep');
                                    }
                                }
                                    //check if someone is trying to change the Owner to same zip
                                if(terriTrig.Owner__c != triggerOld.get(terriTrig.Id).Owner__c){
                                    if(uniqueReps.get(terriTrig.Zip_Code__c)>3 && uniqueReps.containskey(terriTrig.Zip_Code__c)){
                                        terriTrig.addError('A single Zip cannot be assigned to more than three sales rep');
                                    }
                                }
                            }    
                        } 
                    }