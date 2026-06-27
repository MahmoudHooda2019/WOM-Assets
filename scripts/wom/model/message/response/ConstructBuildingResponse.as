package wom.model.message.response
{
   import flash.geom.Point;
   import peak.messaging.AbstractIncomingMessage;
   
   public class ConstructBuildingResponse extends AbstractIncomingMessage
   {
      
      private var _buildingTypeId:int;
      
      private var _position:Point;
      
      private var _success:Boolean;
      
      private var _resultMessage:String;
      
      private var _resultCode:int;
      
      public function ConstructBuildingResponse()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         _resultMessage = param1.resultMessage;
         _success = param1.resultCode == 0;
         _resultCode = param1.resultCode;
         _buildingTypeId = param1.buildingTypeId;
         _position = new Point(param1.position.x,param1.position.y);
      }
      
      public function get buildingTypeId() : int
      {
         return _buildingTypeId;
      }
      
      public function get position() : Point
      {
         return _position;
      }
      
      public function get success() : Boolean
      {
         return _success;
      }
      
      public function get resultMessage() : String
      {
         return _resultMessage;
      }
      
      public function get resultCode() : int
      {
         return _resultCode;
      }
   }
}

