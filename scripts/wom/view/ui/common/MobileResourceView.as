package wom.view.ui.common
{
   import peak.component.mobile.MPBitmapFontTextFormat;
   import wom.view.getCaptionTextFormat;
   
   public class MobileResourceView extends MobileIconLabelView
   {
      
      private var _resourceId:int;
      
      public function MobileResourceView(param1:int, param2:String, param3:String, param4:int = 92, param5:int = 72, param6:Number = 1)
      {
         super(param2,param3,param4,param5,null,getCaptionTextFormat(21,"center",16737894),true,param6);
         _resourceId = param1;
      }
      
      override public function updateTextFormat(param1:Boolean) : void
      {
         _textField.textRendererProperties.textFormat = param1 ? getCaptionTextFormat(21,"center",16737894) : defaultTextFormat;
      }
      
      public function get resourceId() : int
      {
         return _resourceId;
      }
   }
}

