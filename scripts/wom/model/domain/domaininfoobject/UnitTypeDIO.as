package wom.model.domain.domaininfoobject
{
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import peak.i18n.PText;
   import wom.model.dto.ResourceAmountDTO;
   
   public class UnitTypeDIO extends GenericUnitTypeDIO
   {
      
      public var unlockPrerequisite:PrerequisiteDIO;
      
      public var unlockCost:ResourceAmountDTO;
      
      public var unlockDurationInSecs:Number;
      
      public var hiringCostsPerLevel:Vector.<Vector.<ResourceAmountDTO>>;
      
      public var hiringDurationPerLevelInSecs:Vector.<int>;
      
      public var spacesPerLevel:Vector.<int>;
      
      public var trainingCostsPerLevel:Vector.<Vector.<ResourceAmountDTO>>;
      
      public var trainingDurationPerLevelInSecs:Vector.<int>;
      
      public var trainingPrerequisitesPerLevel:Vector.<PrerequisiteDIO>;
      
      public var barracksGoldPricesPerLevel:Vector.<int>;
      
      public var watchpostGoldPricesPerLevel:Vector.<int>;
      
      public var teamSize:int;
      
      public var mastery:Boolean;
      
      public var deprecated:Boolean;
      
      public var animationLoop:Boolean;
      
      public var index:int;
      
      public var trainingChamberOffset:Point;
      
      public function UnitTypeDIO(param1:int, param2:Boolean, param3:Vector.<int>, param4:PrerequisiteDIO, param5:ResourceAmountDTO, param6:Number, param7:Vector.<Number>, param8:Vector.<Number>, param9:Vector.<int>, param10:Vector.<int>, param11:Vector.<Vector.<ResourceAmountDTO>>, param12:Vector.<int>, param13:Vector.<int>, param14:Vector.<Vector.<ResourceAmountDTO>>, param15:Vector.<int>, param16:Vector.<PrerequisiteDIO>, param17:int, param18:Vector.<int>, param19:Vector.<int>, param20:String, param21:Point, param22:int, param23:int, param24:Boolean, param25:Boolean, param26:int, param27:Vector.<int>, param28:Number, param29:Boolean, param30:Boolean, param31:Boolean, param32:Boolean, param33:Dictionary, param34:int, param35:String, param36:Boolean, param37:String, param38:Boolean, param39:Point)
      {
         super(param1,param2,param3,param7,param8,param9,param10,param17,param33,param20,param21,param22,param23,param24,param27,param28,param29,param30,param31,param35,param36,param37);
         this.unlockPrerequisite = param4;
         this.unlockCost = param5;
         this.unlockDurationInSecs = param6;
         this.hiringCostsPerLevel = param11;
         this.hiringDurationPerLevelInSecs = param12;
         this.spacesPerLevel = param13;
         this.trainingCostsPerLevel = param14;
         this.trainingDurationPerLevelInSecs = param15;
         this.trainingPrerequisitesPerLevel = param16;
         this.animationLoop = param25;
         this.index = param26;
         this.watchpostGoldPricesPerLevel = param19;
         this.barracksGoldPricesPerLevel = param18;
         this.teamSize = param34;
         this.mastery = param32;
         this.deprecated = param38;
         this.trainingChamberOffset = param39;
      }
      
      public static function determineFavouriteTargetsOfUnit(param1:UnitTypeDIO) : String
      {
         var _loc3_:String = "";
         if(param1.healer)
         {
            var _loc6_:String = "ui.mainframe.combat.mercenarytooltip.healer";
            _loc3_ = peak.i18n.PText.INSTANCE.getText0(_loc6_);
         }
         else if(param1.targetsAnything)
         {
            var _loc7_:String = "ui.mainframe.combat.mercenarytooltip.anything";
            _loc3_ = peak.i18n.PText.INSTANCE.getText0(_loc7_);
         }
         else
         {
            _loc3_ = "";
            for each(var _loc2_ in param1.favouriteTargets)
            {
               var _temp_1:* = _loc3_;
               var _loc8_:String = "domain.buildingkinds." + _loc2_ + ".name";
               _loc3_ += peak.i18n.PText.INSTANCE.getText0(_loc8_) + ", ";
            }
            _loc3_ = _loc3_.substr(0,_loc3_.length - 2);
         }
         return _loc3_;
      }
   }
}

