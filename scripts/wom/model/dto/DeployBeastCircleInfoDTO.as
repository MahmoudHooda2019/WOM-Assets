package wom.model.dto
{
   import flash.geom.Point;
   import peak.cuckoo.game.dto.Point3;
   
   public class DeployBeastCircleInfoDTO
   {
      
      private var _frameNumber:int;
      
      private var _deployPoint:Point3;
      
      private var _radius:Number;
      
      private var _beastId:int;
      
      private var _beastLevel:int;
      
      private var _beastStage:int;
      
      private var _beastHealth:Number;
      
      public function DeployBeastCircleInfoDTO(param1:int, param2:Point3, param3:int, param4:Number, param5:Number)
      {
         super();
         _beastId = param3;
         _beastHealth = param4;
         _frameNumber = param1;
         _deployPoint = param2;
         _radius = param5;
      }
      
      public static function deserialize(param1:Object) : DeployBeastCircleInfoDTO
      {
         var _loc2_:DeployBeastCircleInfoDTO = new DeployBeastCircleInfoDTO(param1.fn,new Point3(param1.dp.x,param1.dp.y),param1.bi,param1.bh,"rd" in param1 ? param1.rd : 12);
         _loc2_._beastLevel = param1.bl;
         _loc2_._beastStage = param1.bb;
         _loc2_._beastHealth = param1.bh;
         return _loc2_;
      }
      
      public function get frameNumber() : int
      {
         return _frameNumber;
      }
      
      public function get deployPoint() : Point
      {
         return _deployPoint;
      }
      
      public function get radius() : Number
      {
         return _radius;
      }
      
      public function get beastId() : int
      {
         return _beastId;
      }
      
      public function get beastLevel() : int
      {
         return _beastLevel;
      }
      
      public function get beastStage() : int
      {
         return _beastStage;
      }
      
      public function get beastHealth() : Number
      {
         return _beastHealth;
      }
      
      public function serialize() : Object
      {
         if(_radius == 12)
         {
            return {
               "fn":_frameNumber,
               "dp":{
                  "x":_deployPoint.x,
                  "y":_deployPoint.y
               },
               "bi":_beastId,
               "bh":_beastHealth
            };
         }
         return {
            "rd":_radius,
            "fn":_frameNumber,
            "dp":{
               "x":_deployPoint.x,
               "y":_deployPoint.y
            },
            "bi":_beastId,
            "bh":_beastHealth
         };
      }
   }
}

