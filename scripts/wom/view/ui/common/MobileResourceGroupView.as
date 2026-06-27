package wom.view.ui.common
{
   import peak.display.View;
   import peak.util.MobileAlignmentUtil;
   import peak.util.NumberUtil;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.model.dto.ResourceAmountDTO;
   import wom.model.game.resource.ResourceType;
   
   public class MobileResourceGroupView extends Sprite implements View
   {
      
      private var _resourceViews:Vector.<MobileResourceView>;
      
      private var _includeAll:Boolean;
      
      private var _costsMargin:int;
      
      private var _scaleForResourceViews:Number;
      
      private var _iconLabelViewHeight:int;
      
      public function MobileResourceGroupView(param1:Boolean = false, param2:int = 12, param3:Number = 1, param4:int = 72)
      {
         super();
         _includeAll = param1;
         _costsMargin = param2;
         _scaleForResourceViews = param3;
         _iconLabelViewHeight = param4;
         init();
      }
      
      public function init() : void
      {
         _resourceViews = new Vector.<MobileResourceView>();
         initLayout();
      }
      
      public function initLayout() : void
      {
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         var _loc2_:int = 0;
         var _loc1_:DisplayObject = null;
         _loc2_ = 0;
         while(_loc2_ < _resourceViews.length)
         {
            if(_loc2_ != 0)
            {
               MobileAlignmentUtil.alignAccordingToPositionOf(_resourceViews[_loc2_],_loc1_,_resourceViews[_loc2_].componentWidth + _costsMargin,0);
            }
            _loc1_ = _resourceViews[_loc2_];
            _loc2_++;
         }
      }
      
      override public function get width() : Number
      {
         return _resourceViews != null && _resourceViews.length > 0 ? _resourceViews.length * _resourceViews[0].componentWidth + (_resourceViews.length - 1) * _costsMargin : 0;
      }
      
      public function updateWithResources(param1:Vector.<ResourceAmountDTO>) : void
      {
         var _loc8_:Boolean = false;
         var _loc4_:String = null;
         var _loc2_:MobileResourceView = null;
         var _loc6_:int = 0;
         var _loc3_:ResourceAmountDTO = null;
         var _loc5_:int = numChildren;
         while(_loc5_--)
         {
            removeChildAt(0);
         }
         _resourceViews.length = 0;
         for each(var _loc7_ in ResourceType.resourceTypes)
         {
            _loc8_ = false;
            _loc4_ = _loc7_.iconAssetName;
            _loc6_ = 0;
            while(_loc6_ < param1.length && !_loc8_)
            {
               _loc3_ = param1[_loc6_];
               if(_loc3_.resourceType == _loc7_.id && _loc3_.resourceAmount > 0)
               {
                  _loc8_ = true;
                  _loc2_ = new MobileResourceView(_loc7_.id,_loc4_,NumberUtil.format(_loc3_.resourceAmount),92,_iconLabelViewHeight,_scaleForResourceViews);
               }
               _loc6_++;
            }
            if(!_loc8_ && _includeAll)
            {
               _loc2_ = new MobileResourceView(_loc7_.id,_loc4_,"...");
               _loc2_.alpha = 0.5;
            }
            addChild(_loc2_);
            _resourceViews.push(_loc2_);
         }
         drawLayout();
      }
      
      public function get resourceViews() : Vector.<MobileResourceView>
      {
         return _resourceViews;
      }
   }
}

