package wom.model.message.response
{
   import flash.utils.Dictionary;
   import peak.cuckoo.game.attribute.Position;
   import peak.cuckoo.game.dto.Point3;
   import peak.messaging.AbstractIncomingMessage;
   import wom.model.dto.PlannerBuildingDTO;
   
   public class SaveCityPlanResponse extends AbstractIncomingMessage
   {
      
      private var _resultCode:int;
      
      private var _resultMessage:String;
      
      private var _plan:Dictionary;
      
      private var _slot:int;
      
      private var _name:String;
      
      public function SaveCityPlanResponse()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         _resultCode = param1.resultCode;
         _resultMessage = param1.resultMessage;
         _plan = new Dictionary();
         if(param1.plan)
         {
            if(_resultCode == 0)
            {
               for each(var _loc2_ in param1.plan)
               {
                  _plan[_loc2_.id] = new PlannerBuildingDTO(_loc2_.id,new Position(new Point3(_loc2_.position.x,_loc2_.position.y,0)));
               }
            }
            _slot = param1.slot;
            _name = param1.name;
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
      
      public function get name() : String
      {
         return _name;
      }
   }
}

