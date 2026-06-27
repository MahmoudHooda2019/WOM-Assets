package peak.i18n
{
   public function localeCompare(param1:String, param2:String) : int
   {
      return PText.INSTANCE.activeLanguage.collator.compare(param1,param2);
   }
}

