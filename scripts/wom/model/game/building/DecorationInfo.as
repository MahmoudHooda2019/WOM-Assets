package wom.model.game.building
{
   import flash.geom.Point;
   
   public class DecorationInfo
   {
      
      private var _instanceId:int;
      
      private var _decorationTypeId:int;
      
      private var _subType:String;
      
      private var _position:Point;
      
      private var _fromStash:Boolean;
      
      public function DecorationInfo(param1:int, param2:int, param3:String, param4:Point, param5:Boolean = false)
      {
         super();
         _instanceId = param1;
         _decorationTypeId = param2;
         _subType = param3;
         _position = param4;
         _fromStash = param5;
      }
      
      public static function deserialize(param1:Object) : DecorationInfo
      {
         return new DecorationInfo(param1.i,param1.y,param1.st,new Point(param1.p.x,param1.p.y));
      }
      
      public function get instanceId() : int
      {
         return _instanceId;
      }
      
      public function get decorationTypeId() : int
      {
         return _decorationTypeId;
      }
      
      public function get subType() : String
      {
         return _subType;
      }
      
      public function get position() : Point
      {
         return _position;
      }
      
      public function get fromStash() : Boolean
      {
         return _fromStash;
      }
   }
}

