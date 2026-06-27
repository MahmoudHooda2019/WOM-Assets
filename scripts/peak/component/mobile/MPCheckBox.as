package peak.component.mobile
{
   import com.arabicode.text.Flaraby.FlarabyAS3;
   import feathers.controls.Check;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import peak.i18n.lang.Languages;
   import starling.display.DisplayObject;
   
   public class MPCheckBox extends Check
   {
      
      private var _padLeft:Number = 0;
      
      private var _padRight:Number = 0;
      
      private var _padTop:Number = 0;
      
      private var _padBottom:Number = 0;
      
      public var flarabyAS3:FlarabyAS3;
      
      public function MPCheckBox(param1:Boolean = false)
      {
         super();
         this.isFocusEnabled = false;
         this.useHandCursor = true;
         if(Languages.activeLanguageId == "ar")
         {
            flarabyAS3 = new FlarabyAS3();
         }
      }
      
      override public function set label(param1:String) : void
      {
         if(flarabyAS3 != null)
         {
            super.label = flarabyAS3.convertArabicString(param1,this.labelTextRenderer.width,this.defaultLabelProperties.textFormat);
         }
         else
         {
            super.label = param1;
         }
      }
      
      override public function hitTest(param1:Point, param2:Boolean = false) : DisplayObject
      {
         if(param2 && (!visible || !touchable))
         {
            return null;
         }
         var _loc3_:Rectangle = getBounds(this);
         _loc3_.x -= _padLeft;
         _loc3_.width += _padLeft;
         _loc3_.width += _padRight;
         _loc3_.y -= _padTop;
         _loc3_.height += _padTop;
         _loc3_.height += _padBottom;
         if(_loc3_.containsPoint(param1))
         {
            return this;
         }
         return null;
      }
      
      public function setPaddings(param1:Number = 0, param2:Number = 0, param3:Number = 0, param4:Number = 0) : void
      {
         _padLeft = param1;
         _padRight = param2;
         _padTop = param3;
         _padBottom = param4;
      }
   }
}

