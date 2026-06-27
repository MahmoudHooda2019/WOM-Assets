package wom.view.screen.windows.alliance.coa
{
   import flash.display.Graphics;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import peak.component.PRadioButton;
   import peak.display.ButtonCursorManager;
   import wom.model.game.alliance.coa.VanityColorType;
   
   public class VanityColorRadioButton extends PRadioButton
   {
      
      private static const SELECTED_FILTER:GlowFilter = new GlowFilter(0,1,2,2,12);
      
      private var cursorManager:ButtonCursorManager;
      
      private var _colorType:VanityColorType;
      
      public function VanityColorRadioButton(param1:VanityColorType)
      {
         _colorType = param1;
         super();
         this.useHandCursor = true;
         this.textField.width = 0;
         this.textField.height = 0;
         this.width = 22;
         this.height = 23;
         this.value = _colorType;
         cursorManager = new ButtonCursorManager(this);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         var _loc2_:Sprite = new Sprite();
         var _loc1_:Graphics = _loc2_.graphics;
         _loc1_.beginFill(_colorType.color,1);
         _loc1_.drawRoundRect(6,1,20,20,3,3);
         _loc1_.endFill();
         if(icon != null)
         {
            addChildAt(_loc2_,getChildIndex(icon));
         }
         else
         {
            addChild(_loc2_);
         }
      }
      
      override protected function drawIcon() : void
      {
         super.drawIcon();
         icon.width = 22;
         icon.height = 23;
         icon.filters = selected ? [SELECTED_FILTER] : null;
      }
      
      public function get colorType() : VanityColorType
      {
         return _colorType;
      }
   }
}

