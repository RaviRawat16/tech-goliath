                        /*When Opportunity is created
					Add Opportunity Owner's manager as Opportunity Team member with role - Sales Manager
									  If Opportunity Owner is a Manager
						Add one of their direct employee as Sales Rep in Opportunity Team member 
						(Hint: in user object the field ManagerId is the manager for the users)*/


trigger OpportunityTeamMember on Opportunity (After insert) {
    set<id>oppOwnerId = new set<id>();
    for (Opportunity Oppty : Trigger.new){
        oppOwnerId.add(Oppty.Id);
    }
    OpportunityTeamMemberHelper.TeamManager(oppOwnerId);
}