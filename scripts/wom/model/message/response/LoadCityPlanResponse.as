package wom.model.message.response
{
   import flash.utils.Dictionary;
   import peak.cuckoo.game.attribute.Position;
   import peak.cuckoo.game.dto.Point3;
   import peak.messaging.AbstractIncomingMessage;
   import wom.model.dto.PlannerBuildingDTO;
   
   public class LoadCityPlanResponse extends AbstractIncomingMessage
   {
      
      private var _resultCode:int;
      
      private var _resultMessage:String;
      
      private var _slot:int;
      
      private var _name:String;
      
      private var _plan:Dictionary;
      
      public function LoadCityPlanResponse()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         _resultCode = param1.resultCode;
         _resultMessage = param1.resultMessage;
         if(param1.plan != null)
         {
            _slot = param1.plan.slot;
            _name = param1.plan.name;
            _plan = new Dictionary();
            if(_resultCode == 0)
            {
               for each(var _loc2_ in param1.plan.plan)
               {
                  _plan[_loc2_.id] = new PlannerBuildingDTO(_loc2_.id,new Position(new Point3(_loc2_.position.x,_loc2_.position.y,0)));
               }
            }
         }
         else
         {
            _resultCode = 1;
         }
      }
      
      public function get resultCode() : int
      {
         return _resultCode;
      }
      
      public function set resultCode(param1:int) : void
      {
         _resultCode = param1;
      }
      
      public function get resultMessage() : String
      {
         return _resultMessage;
      }
      
      public function set resultMessage(param1:String) : void
      {
         _resultMessage = param1;
      }
      
      public function get plan() : Dictionary
      {
         return _plan;
      }
      
      public function set plan(param1:Dictionary) : void
      {
         _plan = param1;
      }
      
      public function get slot() : int
      {
         return _slot;
      }
      
      public function set slot(param1:int) : void
      {
         _slot = param1;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function set name(param1:String) : void
      {
         _name = param1;
      }
   }
}

