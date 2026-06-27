package wom.view.screen.windows.build
{
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.model.domain.domaininfoobject.BuildingTypeDIO;
   import wom.model.game.building.BuildingTypeVisual;
   import wom.model.resource.MobileWomAssetRepository;
   
   public class MobileBuildingSilhouette extends Sprite
   {
      
      private static const MAX_SCALE_FACTOR:Number = 1.5;
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      private var mainHeight:int = 0;
      
      private var mainXOffset:int = 0;
      
      private var mainYOffset:int = 0;
      
      private var mainSizeFound:Boolean = false;
      
      private var calculatedZIndexes:Dictionary;
      
      private var zIndex:int;
      
      private var overflow:Point;
      
      private var _scaleFactor:Number = 1;
      
      public var buildingTypeDIO:BuildingTypeDIO;
      
      private var level:int;
      
      private var _buildingTypeId:int;
      
      private var minSize:Point;
      
      private var maxSize:Point;
      
      public function MobileBuildingSilhouette(param1:int, param2:int = 1, param3:Point = null, param4:Point = null)
      {
         super();
         _buildingTypeId = param1;
         this.level = param2;
         this.minSize = param3;
         this.maxSize = param4;
      }
      
      [PostConstruct]
      public function construct() : void
      {
         var _loc3_:String = null;
         var _loc2_:DisplayObject = null;
         zIndex = 0;
         calculatedZIndexes = new Dictionary();
         overflow = new Point(0,0);
         var _loc5_:int = level > 0 ? level - 1 : 0;
         var _loc4_:Array = buildingTypeDIO.visualMap[_loc5_][1];
         for each(var _loc1_ in _loc4_)
         {
            calculateZIndex(_loc1_,buildingTypeDIO);
         }
         _loc4_.sort(visualSort);
         for each(_loc1_ in _loc4_)
         {
            _loc3_ = _loc1_.id;
            if(_loc1_.visualType == "Animation")
            {
               _loc3_ += "-0";
               if(buildingTypeDIO.id == 44)
               {
                  continue;
               }
            }
            _loc2_ = assetRepository.getDisplayObject(_loc3_);
            if(_loc1_.mainVisual)
            {
               _loc2_.x = _loc2_.y = 0;
            }
            else
            {
               _loc2_.x = _loc1_.offset.x - mainXOffset;
               _loc2_.y = mainHeight - (_loc1_.offset.y - mainYOffset) - _loc2_.height;
               if(_loc2_.x < overflow.x)
               {
                  overflow.x = _loc2_.x;
               }
               if(_loc2_.y < overflow.y)
               {
                  overflow.y = _loc2_.y;
               }
            }
            addChild(_loc2_);
         }
         if(maxSize && height > maxSize.y)
         {
            if(_scaleFactor > maxSize.y / height)
            {
               _scaleFactor = maxSize.y / height;
            }
         }
         else if(minSize && height < minSize.y)
         {
            if(_scaleFactor < minSize.y / height)
            {
               _scaleFactor = minSize.y / height;
            }
         }
         if(maxSize && width > maxSize.x)
         {
            if(_scaleFactor > maxSize.x / width)
            {
               _scaleFactor = maxSize.x / width;
            }
         }
         else if(minSize && width < minSize.x)
         {
            if(_scaleFactor < minSize.x / width)
            {
               _scaleFactor = minSize.x / width;
            }
         }
         if(_scaleFactor > 1.5)
         {
            _scaleFactor = 1.5;
         }
         scaleX = scaleY = _scaleFactor;
      }
      
      private function visualSort(param1:BuildingTypeVisual, param2:BuildingTypeVisual) : int
      {
         var _loc5_:BuildingTypeVisual = null;
         var _loc4_:String = null;
         var _loc3_:DisplayObject = null;
         if(!mainSizeFound)
         {
            _loc5_ = null;
            if(param1.mainVisual)
            {
               _loc5_ = param1;
            }
            else if(param2.mainVisual)
            {
               _loc5_ = param2;
            }
            if(_loc5_)
            {
               mainSizeFound = true;
               _loc4_ = _loc5_.id;
               if(_loc5_.visualType == "Animation")
               {
                  _loc4_ += "-0";
               }
               _loc3_ = assetRepository.getDisplayObject(_loc4_);
               mainHeight = _loc3_.height;
               mainXOffset = _loc5_.offset.x;
               mainYOffset = _loc5_.offset.y;
            }
         }
         if(calculatedZIndexes[param1.id] > calculatedZIndexes[param2.id])
         {
            return 1;
         }
         if(calculatedZIndexes[param1.id] < calculatedZIndexes[param2.id])
         {
            return -1;
         }
         return 0;
      }
      
      private function calculateZIndex(param1:BuildingTypeVisual, param2:BuildingTypeDIO) : void
      {
         var _loc3_:int = 0;
         if(param1.visualType == "Animation")
         {
            if(param2.id == 29)
            {
               _loc3_ = 61;
            }
            else
            {
               _loc3_ = zIndex + 1;
            }
         }
         else if(param1.mainVisual)
         {
            _loc3_ = 0;
         }
         else if(param1.mainVisualFront)
         {
            _loc3_ = 50;
         }
         else if(param2.id == 43)
         {
            _loc3_ = 0 + 1;
         }
         else
         {
            _loc3_ = -zIndex - 1;
         }
         zIndex = zIndex + 1;
         calculatedZIndexes[param1.id] = _loc3_;
      }
      
      public function get buildingTypeId() : int
      {
         return _buildingTypeId;
      }
      
      override public function get width() : Number
      {
         return super.width - overflow.x * _scaleFactor << 0;
      }
      
      override public function get height() : Number
      {
         return super.height - overflow.y * _scaleFactor << 0;
      }
      
      override public function get x() : Number
      {
         return super.x + overflow.x * _scaleFactor << 0;
      }
      
      override public function set x(param1:Number) : void
      {
         super.x = param1 - overflow.x * _scaleFactor << 0;
      }
      
      override public function get y() : Number
      {
         return super.y + overflow.y * _scaleFactor << 0;
      }
      
      override public function set y(param1:Number) : void
      {
         super.y = param1 - overflow.y * _scaleFactor << 0;
      }
      
      public function get mobileUIOffsetX() : Number
      {
         return buildingTypeDIO.mobileUIOffset.x;
      }
      
      public function get mobileUIOffsetY() : Number
      {
         return buildingTypeDIO.mobileUIOffset.y;
      }
      
      public function set scaleFactor(param1:Number) : void
      {
         _scaleFactor = param1;
      }
   }
}

