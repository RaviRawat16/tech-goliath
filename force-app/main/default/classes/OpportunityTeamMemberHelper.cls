                                        /*When Opportunity is created
					Add Opportunity Owner's manager as Opportunity Team member with role - Sales Manager
									  If Opportunity Owner is a Manager
						Add one of their direct employee as Sales Rep in Opportunity Team member 
						(Hint: in user object the field ManagerId is the manager for the users)*/

public with sharing class OpportunityTeamMemberHelper 
{
    public static void TeamManager(set<Id> oppOwnerId)
     {
    list<Opportunity> oppTeamMember = [select Id,OwnerId, Owner.ManagerId from Opportunity where Id=:oppOwnerId];
    list<OpportunityTeamMember> otmRole = new list<OpportunityTeamMember>();
    for(Opportunity opp: oppTeamMember){
        
        list<User> assistants=[Select Id from User where ManagerId=:opp.OwnerId]; // List of subordinates of a manager
        if(opp.Owner.ManagerId!=Null){
            //when subordiante is opportunity owner
            otmRole.add(new OpportunityTeamMember(UserId=opp.Owner.ManagerId,
            OpportunityId=opp.Id,TeamMemberRole='Sales Manager'));
            otmRole.add(new OpportunityTeamMember(UserId=opp.OwnerId,
            OpportunityId=opp.Id,TeamMemberRole='Sales rep'));
        }
        else if(assistants.size()>0){
            // when manager is opportunity owner
            otmRole.add(new OpportunityTeamMember(UserId=opp.OwnerId ,
            OpportunityId=opp.Id,TeamMemberRole='Sales Manager'));
            otmRole.add(new OpportunityTeamMember(UserId=assistants[0].Id,
            OpportunityId=opp.Id,TeamMemberRole='Sales rep'));
           }
    }
   if(otmRole.size()>0){
        insert otmRole;
    }
}
}