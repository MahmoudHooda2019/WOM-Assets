package wom.model.dto
{
   import flash.geom.Point;
   import peak.cuckoo.game.dto.Point3;
   
   public class DeployedCatapultCircleInfoDTO
   {
      
      private var _frameNumber:int;
      
      private var _deployPoint:Point3;
      
      private var _catapultSize:int;
      
      private var _type:int;
      
      public function DeployedCatapultCircleInfoDTO(param1:int, param2:Point3, param3:int, param4:int)
      {
         super();
         _frameNumber = param1;
         _deployPoint = param2;
         _catapultSize = param3;
         _type = param4;
      }
      
      public static function deserialize(param1:Object) : DeployedCatapultCircleInfoDTO
      {
         return new DeployedCatapultCircleInfoDTO(param1.fn,new Point3(param1.dp.x,param1.dp.y),param1.cs,param1.tp);
      }
      
      public function get frameNumber() : int
      {
         return _frameNumber;
      }
      
      public function get deployPoint() : Point
      {
         return _deployPoint;
      }
      
      public function get catapultSize() : int
      {
         return _catapultSize;
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function serialize() : Object
      {
         return {
            "fn":_frameNumber,
            "dp":{
               "x":_deployPoint.x,
               "y":_deployPoint.y
            },
            "cs":_catapultSize,
            "tp":_type
         };
      }
   }
}

