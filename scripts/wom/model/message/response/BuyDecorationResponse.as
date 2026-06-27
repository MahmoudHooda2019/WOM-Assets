package wom.model.message.response
{
   import flash.geom.Point;
   
   public class BuyDecorationResponse extends DefaultResponse
   {
      
      private var _decorationTypeId:int;
      
      private var _position:Point;
      
      private var _instanceId:int;
      
      private var _subType:String;
      
      public function BuyDecorationResponse()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         super.deserialize(param1);
         _decorationTypeId = param1.decorationTypeId;
         _position = new Point(param1.position.x,param1.position.y);
         _subType = param1.subType;
         _instanceId = param1.instanceId;
      }
      
      public function get decorationTypeId() : int
      {
         return _decorationTypeId;
      }
      
      public function get position() : Point
      {
         return _position;
      }
      
      public function get instanceId() : int
      {
         return _instanceId;
      }
      
      public function get subType() : String
      {
         return _subType;
      }
   }
}

