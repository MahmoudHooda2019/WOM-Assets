package peak.i18n
{
   public function i18nN(param1:String, ... rest) : String
   {
      return PText.INSTANCE.getTextN(param1,rest);
   }
}

