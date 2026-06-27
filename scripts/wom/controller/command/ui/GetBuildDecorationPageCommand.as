package wom.controller.command.ui
{
   import flash.utils.Dictionary;
   import peak.i18n.PText;
   import peak.i18n.lang.Language;
   import peak.i18n.lang.Languages;
   import wom.controller.PCommand;
   import wom.controller.event.ui.BuildDecorationPageReadyEvent;
   import wom.controller.event.ui.GetBuildDecorationPageEvent;
   import wom.model.domain.DomainInfo;
   import wom.model.domain.domaininfoobject.DecorationTypeDIO;
   import wom.model.game.building.BuildMenuDecorationCategory;
   import wom.model.game.building.DecorationVariationInfo;
   
   public class GetBuildDecorationPageCommand extends PCommand
   {
      
      private static var _langToFlagsMap:Dictionary;
      
      [Inject]
      public var event:GetBuildDecorationPageEvent;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      [Inject]
      public var pText:PText;
      
      public function GetBuildDecorationPageCommand()
      {
         super();
      }
      
      private static function generateAllVariations(param1:Vector.<DecorationTypeDIO>) : Vector.<DecorationVariationInfo>
      {
         var _loc3_:Vector.<DecorationVariationInfo> = new Vector.<DecorationVariationInfo>();
         for each(var _loc2_ in param1)
         {
            for each(var _loc4_ in _loc2_.getVariations())
            {
               _loc3_.push(_loc4_);
            }
         }
         return _loc3_;
      }
      
      public static function get langToFlagsMap() : Dictionary
      {
         var _loc4_:Dictionary = null;
         var _loc2_:Dictionary = null;
         var _loc1_:Dictionary = null;
         var _loc5_:Dictionary = null;
         var _loc7_:Dictionary = null;
         var _loc3_:Dictionary = null;
         var _loc8_:Dictionary = null;
         var _loc6_:Dictionary = null;
         if(_langToFlagsMap == null)
         {
            _langToFlagsMap = new Dictionary();
            _loc4_ = new Dictionary();
            _loc2_ = new Dictionary();
            _loc1_ = new Dictionary();
            _loc5_ = new Dictionary();
            _loc7_ = new Dictionary();
            _loc3_ = new Dictionary();
            _loc8_ = new Dictionary();
            _loc6_ = new Dictionary();
            _loc4_["Algeria"] = 15;
            _loc4_["Bahrain"] = 14;
            _loc4_["EGY"] = 13;
            _loc4_["Emirates"] = 12;
            _loc4_["INA"] = 11;
            _loc4_["Iraq"] = 10;
            _loc4_["Jordan"] = 9;
            _loc4_["KSA"] = 8;
            _loc4_["Kuwait"] = 7;
            _loc4_["Libya"] = 6;
            _loc4_["Morocco"] = 5;
            _loc4_["Qatar"] = 4;
            _loc4_["Palestine"] = 3;
            _loc4_["Tunis"] = 2;
            _loc4_["Palestine"] = 1;
            _loc2_["USA"] = 7;
            _loc2_["ENG"] = 6;
            _loc2_["IRL"] = 5;
            _loc2_["SCO"] = 4;
            _loc2_["PHI"] = 3;
            _loc2_["CAN"] = 2;
            _loc2_["AUS"] = 1;
            _loc1_["GER"] = 1;
            _loc5_["FRA"] = 2;
            _loc5_["CAN"] = 1;
            _loc7_["ITA"] = 1;
            _loc3_["SPA"] = 2;
            _loc3_["MEX"] = 1;
            _loc8_["POR"] = 2;
            _loc8_["BRA"] = 1;
            _loc6_["TUR"] = 1;
            langToFlagsMap[Languages.ARABIC.id] = _loc4_;
            langToFlagsMap[Languages.ENGLISH.id] = _loc2_;
            langToFlagsMap[Languages.GERMAN.id] = _loc1_;
            langToFlagsMap[Languages.FRENCH.id] = _loc5_;
            langToFlagsMap[Languages.ITALIAN.id] = _loc7_;
            langToFlagsMap[Languages.SPANISH.id] = _loc3_;
            langToFlagsMap[Languages.PORTUGUESE.id] = _loc8_;
            langToFlagsMap[Languages.TURKISH.id] = _loc6_;
         }
         return _langToFlagsMap;
      }
      
      override public function execute() : void
      {
         var _loc7_:int = 0;
         var _loc4_:int = event.pageNumber;
         var _loc2_:BuildMenuDecorationCategory = event.category;
         var _loc6_:Vector.<DecorationTypeDIO> = getDecorationsByCategory(_loc2_);
         var _loc3_:Vector.<DecorationVariationInfo> = generateAllVariations(_loc6_);
         if(_loc2_ == BuildMenuDecorationCategory.FLAGS)
         {
            _loc3_.sort(sortOnActiveLanguage);
         }
         var _loc1_:int = Math.ceil(_loc3_.length / event.itemCountPerPage);
         var _loc5_:Vector.<*> = new Vector.<*>();
         if(_loc4_ == 2147483647)
         {
            _loc4_ = _loc1_ - 1;
         }
         _loc7_ = _loc4_ * event.itemCountPerPage;
         while(_loc7_ < (_loc4_ + 1) * event.itemCountPerPage && _loc7_ < _loc3_.length)
         {
            _loc5_.push(_loc3_[_loc7_]);
            _loc7_++;
         }
         dispatch(new BuildDecorationPageReadyEvent("buildDecorationPageReady",_loc4_,_loc3_.length,_loc5_,_loc2_));
      }
      
      private function getDecorationsByCategory(param1:BuildMenuDecorationCategory) : Vector.<DecorationTypeDIO>
      {
         if(param1.id != BuildMenuDecorationCategory.UNKNOWN.id)
         {
            return domainInfo.getDecorationsByBuildMenuCategory(param1);
         }
         return null;
      }
      
      private function sortOnActiveLanguage(param1:DecorationVariationInfo, param2:DecorationVariationInfo) : Number
      {
         var _loc4_:Language = pText.activeLanguage;
         if(!(_loc4_.id in langToFlagsMap))
         {
            return 0;
         }
         var _loc5_:int = int(langToFlagsMap[_loc4_.id][param1.kind]);
         var _loc3_:int = int(langToFlagsMap[_loc4_.id][param2.kind]);
         if(_loc5_ < _loc3_)
         {
            return 1;
         }
         if(_loc5_ > _loc3_)
         {
            return -1;
         }
         return 0;
      }
   }
}

