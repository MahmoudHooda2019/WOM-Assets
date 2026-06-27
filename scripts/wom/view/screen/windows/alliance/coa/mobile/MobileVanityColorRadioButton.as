package wom.view.screen.windows.alliance.coa.mobile
{
   import peak.component.mobile.MPRadioButton;
   import starling.display.Shape;
   import wom.model.game.alliance.coa.VanityColorType;
   
   public class MobileVanityColorRadioButton extends MPRadioButton
   {
      
      private var _colorType:VanityColorType;
      
      private var selectionBG:Shape;
      
      public function MobileVanityColorRadioButton(param1:VanityColorType)
      {
         _colorType = param1;
         super();
         this.useHandCursor = true;
         this.width = 54;
         this.height = 54;
         configUI();
      }
      
      protected function configUI() : void
      {
         selectionBG = new Shape();
         selectionBG.graphics.beginFill(0,1);
         selectionBG.graphics.drawRoundRect(1,1,60,60,3);
         selectionBG.graphics.endFill();
         selectionBG.visible = _isSelected;
         if(defaultIcon != null)
         {
            addChildAt(selectionBG,getChildIndex(defaultIcon));
         }
         else
         {
            addChild(selectionBG);
         }
         var _loc1_:Shape = new Shape();
         _loc1_.graphics.beginFill(_colorType.color,1);
         _loc1_.graphics.drawRoundRect(4,4,54,54,3);
         _loc1_.graphics.endFill();
         if(defaultIcon != null)
         {
            addChildAt(_loc1_,getChildIndex(defaultIcon));
         }
         else
         {
            addChild(_loc1_);
         }
      }
      
      public function get colorType() : VanityColorType
      {
         return _colorType;
      }
      
      override public function set isSelected(param1:Boolean) : void
      {
         if(!param1 && _toggleGroup && _toggleGroup.isSelectionRequired && _toggleGroup.selectedItem == this)
         {
            return;
         }
         super.isSelected = param1;
         selectionBG.visible = param1;
      }
   }
}

