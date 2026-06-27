package wom.model.dto
{
   import flash.geom.Point;
   import peak.cuckoo.game.dto.Point3;
   
   public class DeployUnitCircleInfoDTO
   {
      
      private var _frameNumber:int;
      
      private var _deployPoint:Point3;
      
      private var _radius:Number;
      
      private var _unitInfo:Vector.<UnitTypeAmountDTO>;
      
      private var _timeDifference:Number;
      
      public function DeployUnitCircleInfoDTO(param1:int, param2:Point3, param3:Number, param4:Vector.<UnitTypeAmountDTO>, param5:Number)
      {
         super();
         this._frameNumber = param1;
         this._deployPoint = param2;
         this._radius = param3;
         this._unitInfo = param4;
         this._timeDifference = param5;
      }
      
      public static function deserialize(param1:Object) : DeployUnitCircleInfoDTO
      {
         var _loc3_:Vector.<UnitTypeAmountDTO> = new Vector.<UnitTypeAmountDTO>(0);
         for each(var _loc2_ in param1.ui)
         {
            _loc3_.push(new UnitTypeAmountDTO(_loc2_.id,_loc2_.amount));
         }
         return new DeployUnitCircleInfoDTO(param1.fn,new Point3(param1.dp.x,param1.dp.y),"rd" in param1 ? param1.rd : 12,_loc3_,param1.td);
      }
      
      public function get frameNumber() : int
      {
         return _frameNumber;
      }
      
      public function get deployPoint() : Point
      {
         return _deployPoint;
      }
      
      public function get unitInfo() : Vector.<UnitTypeAmountDTO>
      {
         return _unitInfo;
      }
      
      public function get radius() : Number
      {
         return _radius;
      }
      
      public function serialize() : Object
      {
         var _loc2_:Array = [];
         for each(var _loc1_ in _unitInfo)
         {
            _loc2_.push({
               "id":_loc1_.id,
               "amount":_loc1_.amount
            });
         }
         if(_radius == 12)
         {
            return {
               "ui":_loc2_,
               "dp":{
                  "x":_deployPoint.x,
                  "y":_deployPoint.y
               },
               "fn":_frameNumber,
               "td":_timeDifference
            };
         }
         return {
            "ui":_loc2_,
            "dp":{
               "x":_deployPoint.x,
               "y":_deployPoint.y
            },
            "fn":_frameNumber,
            "rd":_radius,
            "td":_timeDifference
         };
      }
   }
}

