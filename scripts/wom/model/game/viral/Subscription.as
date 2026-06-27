package wom.model.game.viral
{
   public class Subscription
   {
      
      public static const INVALID_ACTION:Subscription = new Subscription(0,"INVALID_ACTION");
      
      public static const BEAST_READY_FOR_TRAINING:Subscription = new Subscription(1,"BEAST_READY_FOR_TRAINING");
      
      public static const BEAST_HEALTH_IS_FULL:Subscription = new Subscription(2,"BEAST_HEALTH_IS_FULL");
      
      public static const CONSTRUCTION_FINISHED:Subscription = new Subscription(3,"CONSTRUCTION_FINISHED");
      
      public static const MERCENARY_TRAINING_OR_RECRUITMENT_FINISHED:Subscription = new Subscription(4,"MERCENARY_TRAINING_OR_RECRUITMENT_FINISHED");
      
      public static const BASE_OR_OUTPOST_ATTACKED:Subscription = new Subscription(5,"BASE_OR_OUTPOST_ATTACKED");
      
      public static const AT_LEAST_ONE_RESOURCE_PRODUCER_IS_FULL:Subscription = new Subscription(6,"AT_LEAST_ONE_RESOURCE_PRODUCER_IS_FULL");
      
      public static const ALL_HIRING_JOBS_COMPLETED:Subscription = new Subscription(7,"ALL_HIRING_JOBS_COMPLETED");
      
      public static const A_NEW_GAME_FEATURE_IS_OUT:Subscription = new Subscription(8,"A_NEW_GAME_FEATURE_IS_OUT");
      
      public static const availableSubscriptions:Array = [BEAST_READY_FOR_TRAINING,BEAST_HEALTH_IS_FULL,CONSTRUCTION_FINISHED,MERCENARY_TRAINING_OR_RECRUITMENT_FINISHED,ALL_HIRING_JOBS_COMPLETED,A_NEW_GAME_FEATURE_IS_OUT];
      
      private var _id:int;
      
      private var _name:String;
      
      public function Subscription(param1:int, param2:String)
      {
         super();
         _id = param1;
         _name = param2;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get name() : String
      {
         return _name;
      }
   }
}

