package wom.view.ui.common
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import peak.display.View;
   import peak.util.AlignmentUtil;
   import peak.util.NumberUtil;
   import wom.model.dto.ResourceAmountDTO;
   import wom.model.game.resource.ResourceType;
   
   public class ResourceGroupView extends Sprite implements View
   {
      
      private var _resourceViews:Vector.<ResourceView>;
      
      private var _includeAll:Boolean;
      
      private var _costsMargin:int;
      
      private var _scaleForResourceViews:Number;
      
      private var _iconLabelViewHeight:int;
      
      public function ResourceGroupView(param1:Boolean = false, param2:int = 0, param3:Number = 1, param4:int = 70)
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
         _resourceViews = new Vector.<ResourceView>();
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
               AlignmentUtil.alignRightOf(_resourceViews[_loc2_],_loc1_,_costsMargin);
            }
            _loc1_ = _resourceViews[_loc2_];
            _loc2_++;
         }
      }
      
      public function updateWithResources(param1:Vector.<ResourceAmountDTO>) : void
      {
         var _loc6_:Boolean = false;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc3_:ResourceAmountDTO = null;
         var _loc2_:ResourceView = null;
         removeChildren();
         _resourceViews = new Vector.<ResourceView>();
         for each(var _loc7_ in ResourceType.resourceTypes)
         {
            _loc6_ = false;
            _loc4_ = _loc7_.iconAssetName;
            _loc5_ = 0;
            while(_loc5_ < param1.length)
            {
               _loc3_ = param1[_loc5_];
               if(_loc3_.resourceType == _loc7_.id && _loc3_.resourceAmount > 0)
               {
                  _loc2_ = new ResourceView(_loc7_.id,_loc4_,NumberUtil.format(_loc3_.resourceAmount),95,_iconLabelViewHeight,_scaleForResourceViews);
                  addChild(_loc2_);
                  _resourceViews.push(_loc2_);
                  _loc6_ = true;
                  break;
               }
               _loc5_++;
            }
            if(!_loc6_ && _includeAll)
            {
               _loc2_ = new ResourceView(_loc7_.id,_loc4_,"...");
               _loc2_.alpha = 0.5;
               addChild(_loc2_);
               _resourceViews.push(_loc2_);
            }
         }
         drawLayout();
      }
      
      public function get resourceViews() : Vector.<ResourceView>
      {
         return _resourceViews;
      }
   }
}

