package wom.view
{
   import peak.component.mobile.MPBitmapFontTextFormat;
   import wom.view.component.MobileWomTextFormats;
   
   public function getWomTextFormat(param1:Number, param2:String = "left", param3:uint = 0, param4:uint = 0) : MPBitmapFontTextFormat
   {
      return MobileWomTextFormats.getTextFormat("BL",param1,param2,param3,param4);
   }
}

