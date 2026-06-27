package wom.controller.event.tutorial
{
   import flash.events.Event;
   
   public class TutorialEvent extends Event
   {
      
      public static const CREATE_TUTORIALS:String = "createTutorials";
      
      public static const ENABLE_TUTORIALS:String = "enableTutorials";
      
      public static const SAVE_TUTORIALS_TO_SERVER:String = "saveTutorialsToServer";
      
      public static const TUTORIALS_UPDATED:String = "tutorialsUpdated";
      
      public static const MANDATORY_TUTORIALS_COMPLETION_CHANGED:String = "mandatoryTutorialsCompletionChanged";
      
      public static const MANDATORY_TUTORIALS_COMPLETED:String = "mandatoryTutorialsCompleted";
      
      public static const SET_MANDATORY_TUTORIALS_COMPLETED:String = "setMandatoryTutorialsCompleted";
      
      public static const SKIP_TUTORIAL:String = "skipTutorial";
      
      public static const DISABLE_TUTORIALS:String = "disableTutorials";
      
      public static const RESET_TUTORIALS_ON_SERVER:String = "resetTutorialsOnServer";
      
      private var _tutorialId:String;
      
      public function TutorialEvent(param1:String, param2:String = null)
      {
         super(param1);
         _tutorialId = param2 != null ? param2 : "unk";
      }
      
      override public function clone() : Event
      {
         return new TutorialEvent(type,_tutorialId);
      }
      
      public function get tutorialId() : String
      {
         return _tutorialId;
      }
   }
}

