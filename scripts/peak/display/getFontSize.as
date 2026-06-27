package peak.display
{
   import peak.i18n.lang.Languages;
   
   public function getFontSize(param1:int) : int
   {
      return Languages.isActiveLanguageEmdedded() ? param1 : param1 - 4;
   }
}

