package wom.model.domain
{
   import flash.geom.Point;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import peak.i18n.PText;
   import peak.serialization.json.PJSON;
   import peak.util.BiMap;
   import wom.model.component.enum.ActionType;
   import wom.model.configuration.WomDocumentConfiguration;
   import wom.model.domain.domaininfoobject.BeastTypeDIO;
   import wom.model.domain.domaininfoobject.BuildingSpecificInfoType;
   import wom.model.domain.domaininfoobject.BuildingTypeDIO;
   import wom.model.domain.domaininfoobject.CatapultTypeDIO;
   import wom.model.domain.domaininfoobject.ConstantsDIO;
   import wom.model.domain.domaininfoobject.ConstructableKindTypeDIO;
   import wom.model.domain.domaininfoobject.DecorationTypeDIO;
   import wom.model.domain.domaininfoobject.EventItemDIO;
   import wom.model.domain.domaininfoobject.FortificationInfoDIO;
   import wom.model.domain.domaininfoobject.LeagueLevelDIO;
   import wom.model.domain.domaininfoobject.MultipleInstancePrerequisitesDIO;
   import wom.model.domain.domaininfoobject.PartTypeDIO;
   import wom.model.domain.domaininfoobject.PrerequisiteDIO;
   import wom.model.domain.domaininfoobject.StaffDIO;
   import wom.model.domain.domaininfoobject.TavernItemDIO;
   import wom.model.domain.domaininfoobject.UnitSpecificInfoType;
   import wom.model.domain.domaininfoobject.UnitTypeDIO;
   import wom.model.domain.domaininfoobject.WorkerTypeDIO;
   import wom.model.dto.CatapultEffectTypeDTO;
   import wom.model.dto.PartInfoDTO;
   import wom.model.dto.ResourceAmountDTO;
   import wom.model.dto.UnitTypeAmountDTO;
   import wom.model.game.building.BuildMenuCategory;
   import wom.model.game.building.BuildMenuDecorationCategory;
   import wom.model.game.building.BuildingTypeVisual;
   import wom.model.game.building.FortificationType;
   import wom.model.game.building.ScaffoldType;
   import wom.model.game.resource.ResourceType;
   import wom.model.game.unit.UnitAccessType;
   
   public class JsonPopulatedDomainInfo implements DomainInfo
   {
      
      private static const DomainInfoSource:Class = domaininfo_json$72e84797a62c19b20e08a7ece870e76c1279259078;
      
      private static const VisualInfoSource:Class = visualconfig_json$fba4de3dadd506db5a6fdc765a4451eb2122228086;
      
      private static const CampaignLayoutSource:Class = campaignlayout_json$3d0a7a4bffaf3b3461b49860e8814867695163278;
      
      private static const MapLayoutSource:Class = §maplayout_json$85c5ffe3103ff9278aab6dacbb603121-628784820§;
      
      private static const TerrainLayoutSource:Class = §terrainlayout_json$86ae60df05ab89c28da48df65abec35b-1727427003§;
      
      [Inject]
      public var documentConfiguration:WomDocumentConfiguration;
      
      private var domainInfo:Object;
      
      private var visualInfo:Object;
      
      private var _mapLayout:Object;
      
      private var _campaignLayout:Object;
      
      private var _terrainLayout:Object;
      
      private var resourceNameIdMap:BiMap;
      
      private var partNameIdMap:BiMap;
      
      private var buildingKindNameIdMap:BiMap;
      
      private var buildingNameIdMap:BiMap;
      
      private var unitNameIdMap:BiMap;
      
      private var staffNameIdMap:BiMap;
      
      private var layerNameIdMap:BiMap;
      
      private var buildMenuCategoryNameIdMap:BiMap;
      
      private var buildMenuDecorationCategoryNameIdMap:BiMap;
      
      private var actionTypeNameIdMap:BiMap;
      
      private var buildingMap:Dictionary;
      
      private var buildingVector:Vector.<BuildingTypeDIO>;
      
      private var decorationMap:Dictionary;
      
      private var decorationVector:Vector.<DecorationTypeDIO>;
      
      private var partBuildingMap:Dictionary;
      
      private var partMap:Dictionary;
      
      private var unitMap:Dictionary;
      
      private var unitVector:Vector.<UnitTypeDIO>;
      
      private var deprecatedUnitVector:Vector.<UnitTypeDIO>;
      
      private var constructableKindMap:Dictionary;
      
      private var buildingKindVector:Vector.<ConstructableKindTypeDIO>;
      
      private var _worker:WorkerTypeDIO;
      
      private var _constants:ConstantsDIO;
      
      private var _beastMap:Dictionary;
      
      private var beastVector:Vector.<BeastTypeDIO>;
      
      private var _catapultMap:Dictionary;
      
      private var catapultVector:Vector.<CatapultTypeDIO>;
      
      private var _staffMap:Dictionary;
      
      private var staffVector:Vector.<StaffDIO>;
      
      private var _eventItemMap:Dictionary;
      
      private var eventItemVector:Vector.<EventItemDIO>;
      
      private var _leagueLevelMap:Dictionary;
      
      private var _leagueLevelVector:Vector.<LeagueLevelDIO>;
      
      private var _tavernItemMap:Dictionary;
      
      private var _tavernItemVector:Vector.<TavernItemDIO>;
      
      private var _tavernItemUnlockMap:Dictionary;
      
      public function JsonPopulatedDomainInfo()
      {
         super();
      }
      
      private static function populateEventItem(param1:Object) : EventItemDIO
      {
         var _loc2_:Boolean = Boolean("war_building" in param1 ? param1.war_building : false);
         return new EventItemDIO(param1.id,param1.item_type,param1.name,param1.asset_name,param1.related_id,_loc2_);
      }
      
      private static function onUnitSort(param1:UnitTypeDIO, param2:UnitTypeDIO) : int
      {
         if(param1.index < param2.index)
         {
            return -1;
         }
         if(param1.index > param2.index)
         {
            return 1;
         }
         return 0;
      }
      
      private static function populatePart(param1:Object, param2:Object, param3:Vector.<int>, param4:BiMap) : PartTypeDIO
      {
         return new PartTypeDIO(param1.id,param2.visual,param1.buying_gold_price,param1.buying_rp_price,param4[param1.selling_resource_type],param3);
      }
      
      private static function compareBuildingsOnBuildMenuIndex(param1:BuildingTypeDIO, param2:BuildingTypeDIO) : int
      {
         if(param1.buildMenuIndex == param2.buildMenuIndex)
         {
            return 0;
         }
         if(param1.buildMenuIndex > param2.buildMenuIndex)
         {
            return 1;
         }
         return -1;
      }
      
      private static function onBeastSort(param1:BeastTypeDIO, param2:BeastTypeDIO) : int
      {
         if(param1.id < param2.id)
         {
            return -1;
         }
         if(param1.id > param2.id)
         {
            return 1;
         }
         return 0;
      }
      
      private static function onStaffSort(param1:StaffDIO, param2:StaffDIO) : int
      {
         if(param1.id < param2.id)
         {
            return -1;
         }
         if(param1.id > param2.id)
         {
            return 1;
         }
         return 0;
      }
      
      private static function populateTavernItem(param1:Object) : TavernItemDIO
      {
         return new TavernItemDIO(int(param1.id),String(param1.asset_name.m.asset),int(param1.order),"unlock_index" in param1 ? int(param1.unlock_index) : -1,"scale" in param1.asset_name.m ? Number(param1.asset_name.m.scale) : 1);
      }
      
      private static function onTavernItemSort(param1:TavernItemDIO, param2:TavernItemDIO) : int
      {
         if(param1.visualOrder < param2.visualOrder)
         {
            return -1;
         }
         if(param1.visualOrder > param2.visualOrder)
         {
            return 1;
         }
         return 0;
      }
      
      public function init() : void
      {
         var _loc3_:String = null;
         var _loc7_:ByteArray = null;
         var _loc13_:Object = null;
         if(documentConfiguration.hasParameter("visual"))
         {
            _loc3_ = documentConfiguration.getParameter("visual");
            var _loc16_:String = _loc3_;
            _loc13_ = JSON.parse(_loc16_);
         }
         _loc7_ = new DomainInfoSource();
         var _loc5_:String;
         var _loc17_:String = _loc5_ = _loc7_.readUTFBytes(_loc7_.length);
         domainInfo = JSON.parse(_loc17_);
         var _loc11_:ByteArray = new VisualInfoSource();
         var _loc1_:String = _loc11_.readUTFBytes(_loc11_.length);
         var _loc18_:String;
         visualInfo = _loc13_ != null ? _loc13_ : (_loc18_ = _loc1_,JSON.parse(_loc18_));
         var _loc2_:ByteArray = new MapLayoutSource();
         var _loc10_:String;
         var _loc19_:String = _loc10_ = _loc2_.readUTFBytes(_loc2_.length);
         _mapLayout = JSON.parse(_loc19_);
         var _loc9_:ByteArray = new CampaignLayoutSource();
         var _loc8_:String;
         var _loc20_:String = _loc8_ = _loc9_.readUTFBytes(_loc9_.length);
         _campaignLayout = JSON.parse(_loc20_);
         var _loc12_:ByteArray = new TerrainLayoutSource();
         var _loc4_:String;
         var _loc21_:String = _loc4_ = _loc12_.readUTFBytes(_loc12_.length);
         _terrainLayout = JSON.parse(_loc21_);
         for each(var _loc6_ in [_loc7_,_loc11_,_loc2_,_loc9_,_loc12_])
         {
            _loc6_.clear();
         }
         extractInformation();
         preprocessDomainInfo();
         preprocessVisualInfo();
         populateConstants();
         populateAllStaffs();
         populateAllBuildingKinds();
         populateAllBuildings();
         populateAllDecorations();
         populatePartBuildingMap();
         populateAllParts();
         populateAllUnits();
         populateAllBeasts();
         populateAllCatapults();
         populateFortifications();
         populateScaffolds();
         populateWorker();
         populateEventItems();
         populateAllLeagueLevels();
         populateAllTavernItems();
      }
      
      private function populateAllBuildingKinds() : void
      {
         var _loc1_:ConstructableKindTypeDIO = null;
         constructableKindMap = new Dictionary();
         buildingKindVector = new Vector.<ConstructableKindTypeDIO>();
         for each(var _loc2_ in visualInfo["building_kinds"])
         {
            _loc1_ = populateBuildingKind(_loc2_);
            constructableKindMap[_loc1_.id] = _loc1_;
            buildingKindVector.push(_loc1_);
         }
      }
      
      private function populateBuildingKind(param1:Object) : ConstructableKindTypeDIO
      {
         var _loc2_:int = int(param1["id"]);
         var _loc5_:String = "0x00FF00";
         var _loc3_:String = "0xFFFFFF";
         if("color" in param1)
         {
            _loc5_ = param1["color"];
         }
         var _loc4_:int = parseInt(_loc5_);
         if("outline" in param1)
         {
            _loc3_ = param1["outline"];
         }
         var _loc6_:int = parseInt(_loc3_);
         return new ConstructableKindTypeDIO(_loc2_,_loc4_,_loc6_);
      }
      
      private function populateConstants() : void
      {
         var _loc1_:Number = 1;
         if("yard_unit_per_second" in visualInfo["constants"])
         {
            _loc1_ = Number(visualInfo["constants"]["yard_unit_per_second"]);
         }
         _constants = new ConstantsDIO(_loc1_);
      }
      
      private function extractInformation() : void
      {
         layerNameIdMap = new BiMap();
         for each(var _loc8_ in visualInfo["layers"])
         {
            layerNameIdMap.put(_loc8_["name"],_loc8_["id"]);
         }
         buildMenuCategoryNameIdMap = new BiMap();
         for each(var _loc7_ in visualInfo["build_menu_categories"])
         {
            buildMenuCategoryNameIdMap.put(_loc7_["name"],_loc7_["id"]);
         }
         buildMenuDecorationCategoryNameIdMap = new BiMap();
         for each(var _loc2_ in visualInfo["building_menu_decoration_categories"])
         {
            buildMenuDecorationCategoryNameIdMap.put(_loc2_["name"],_loc2_["id"]);
         }
         actionTypeNameIdMap = new BiMap();
         for each(var _loc4_ in visualInfo["action_types"])
         {
            actionTypeNameIdMap.put(_loc4_["name"],_loc4_["id"]);
         }
         resourceNameIdMap = new BiMap();
         for each(var _loc3_ in domainInfo["resources"])
         {
            resourceNameIdMap.put(_loc3_["name"],_loc3_["id"]);
         }
         partNameIdMap = new BiMap();
         for each(var _loc6_ in domainInfo["parts"])
         {
            partNameIdMap.put(_loc6_["name"],_loc6_["id"]);
         }
         buildingKindNameIdMap = new BiMap();
         for each(var _loc10_ in visualInfo["building_kinds"])
         {
            buildingKindNameIdMap.put(_loc10_["name"],_loc10_["id"]);
         }
         buildingNameIdMap = new BiMap();
         for each(var _loc9_ in domainInfo["buildings"])
         {
            buildingNameIdMap.put(_loc9_["name"],_loc9_["id"]);
         }
         unitNameIdMap = new BiMap();
         for each(var _loc5_ in domainInfo["units"])
         {
            unitNameIdMap.put(_loc5_["name"],_loc5_["id"]);
         }
         staffNameIdMap = new BiMap();
         for each(var _loc1_ in domainInfo["staffs"])
         {
            staffNameIdMap.put(_loc1_["name"],_loc1_["id"]);
         }
      }
      
      private function preprocessDomainInfo() : void
      {
         var _loc8_:int = 0;
         var _loc3_:int = 0;
         var _loc1_:int = 0;
         var _loc7_:int = 0;
         var _loc4_:int = 0;
         var _loc9_:int = 0;
         var _loc11_:int = 0;
         var _loc13_:int = 0;
         var _loc10_:int = 0;
         var _loc6_:int = 0;
         var _loc2_:int = 0;
         var _loc5_:int = 0;
         var _loc12_:int = 0;
         _loc8_ = 0;
         while(_loc8_ < domainInfo["buildings"].length)
         {
            domainInfo["buildings"][_loc8_]["kind"] = buildingKindNameIdMap.getValue(domainInfo["buildings"][_loc8_]["kind"]);
            _loc3_ = 0;
            while(_loc3_ < domainInfo["buildings"][_loc8_]["resource_costs"].length)
            {
               domainInfo["buildings"][_loc8_]["resource_costs"][_loc3_]["resource"] = resourceNameIdMap.getValue(domainInfo["buildings"][_loc8_]["resource_costs"][_loc3_]["resource"]);
               _loc3_++;
            }
            if("fortification_info" in domainInfo["buildings"][_loc8_])
            {
               _loc3_ = 0;
               while(_loc3_ < domainInfo["buildings"][_loc8_]["fortification_info"]["resource_costs"].length)
               {
                  domainInfo["buildings"][_loc8_]["fortification_info"]["resource_costs"][_loc3_]["resource"] = resourceNameIdMap.getValue(domainInfo["buildings"][_loc8_]["fortification_info"]["resource_costs"][_loc3_]["resource"]);
                  _loc3_++;
               }
               _loc1_ = 0;
               while(_loc1_ < domainInfo["buildings"][_loc8_]["fortification_info"]["building_prerequisites_per_level"].length)
               {
                  _loc7_ = 0;
                  while(_loc7_ < domainInfo["buildings"][_loc8_]["fortification_info"]["building_prerequisites_per_level"][_loc1_].length)
                  {
                     domainInfo["buildings"][_loc8_]["fortification_info"]["building_prerequisites_per_level"][_loc1_][_loc7_]["building"] = buildingNameIdMap.getValue(domainInfo["buildings"][_loc8_]["fortification_info"]["building_prerequisites_per_level"][_loc1_][_loc7_]["building"]);
                     _loc7_++;
                  }
                  _loc1_++;
               }
            }
            if("building_prerequisites_per_level" in domainInfo["buildings"][_loc8_])
            {
               _loc1_ = 0;
               while(_loc1_ < domainInfo["buildings"][_loc8_]["building_prerequisites_per_level"].length)
               {
                  _loc7_ = 0;
                  while(_loc7_ < domainInfo["buildings"][_loc8_]["building_prerequisites_per_level"][_loc1_].length)
                  {
                     domainInfo["buildings"][_loc8_]["building_prerequisites_per_level"][_loc1_][_loc7_]["building"] = buildingNameIdMap.getValue(domainInfo["buildings"][_loc8_]["building_prerequisites_per_level"][_loc1_][_loc7_]["building"]);
                     _loc7_++;
                  }
                  _loc1_++;
               }
            }
            if("building_prerequisites_per_instance" in domainInfo["buildings"][_loc8_])
            {
               _loc1_ = 0;
               while(_loc1_ < domainInfo["buildings"][_loc8_]["building_prerequisites_per_instance"].length)
               {
                  _loc7_ = 0;
                  while(_loc7_ < domainInfo["buildings"][_loc8_]["building_prerequisites_per_instance"][_loc1_].length)
                  {
                     domainInfo["buildings"][_loc8_]["building_prerequisites_per_instance"][_loc1_][_loc7_]["building"] = buildingNameIdMap.getValue(domainInfo["buildings"][_loc8_]["building_prerequisites_per_instance"][_loc1_][_loc7_]["building"]);
                     _loc7_++;
                  }
                  _loc1_++;
               }
            }
            if("multiple_instance_prerequisites" in domainInfo["buildings"][_loc8_])
            {
               _loc13_ = 0;
               while(_loc13_ < domainInfo["buildings"][_loc8_]["multiple_instance_prerequisites"].length)
               {
                  _loc1_ = 0;
                  while(_loc1_ < domainInfo["buildings"][_loc8_]["multiple_instance_prerequisites"][_loc13_]["prerequisites"].length)
                  {
                     domainInfo["buildings"][_loc8_]["multiple_instance_prerequisites"][_loc13_]["prerequisites"][_loc1_]["building"] = buildingNameIdMap.getValue(domainInfo["buildings"][_loc8_]["multiple_instance_prerequisites"][_loc13_]["prerequisites"][_loc1_]["building"]);
                     _loc1_++;
                  }
                  _loc13_++;
               }
            }
            if("produced_resource" in domainInfo["buildings"][_loc8_])
            {
               domainInfo["buildings"][_loc8_]["produced_resource"] = resourceNameIdMap.getValue(domainInfo["buildings"][_loc8_]["produced_resource"]);
            }
            if("part_requirements" in domainInfo["buildings"][_loc8_])
            {
               _loc4_ = 0;
               while(_loc4_ < domainInfo["buildings"][_loc8_]["part_requirements"].length)
               {
                  domainInfo["buildings"][_loc8_]["part_requirements"][_loc4_]["part"] = partNameIdMap.getValue(domainInfo["buildings"][_loc8_]["part_requirements"][_loc4_]["part"]);
                  _loc4_++;
               }
            }
            if("staff_prerequisites_per_level" in domainInfo["buildings"][_loc8_])
            {
               _loc11_ = 0;
               while(_loc11_ < domainInfo["buildings"][_loc8_]["staff_prerequisites_per_level"].length)
               {
                  _loc9_ = 0;
                  while(_loc9_ < domainInfo["buildings"][_loc8_]["staff_prerequisites_per_level"][_loc11_].length)
                  {
                     domainInfo["buildings"][_loc8_]["staff_prerequisites_per_level"][_loc11_][_loc9_] = staffNameIdMap.getValue(domainInfo["buildings"][_loc8_]["staff_prerequisites_per_level"][_loc11_][_loc9_]);
                     _loc9_++;
                  }
                  _loc11_++;
               }
            }
            _loc8_++;
         }
         _loc10_ = 0;
         while(_loc10_ < domainInfo["units"].length)
         {
            domainInfo["units"][_loc10_]["unlock_prerequisite"]["building"] = buildingNameIdMap.getValue(domainInfo["units"][_loc10_]["unlock_prerequisite"]["building"]);
            if("hiring_costs_per_level" in domainInfo["units"][_loc10_])
            {
               _loc3_ = 0;
               while(_loc3_ < domainInfo["units"][_loc10_]["hiring_costs_per_level"].length)
               {
                  domainInfo["units"][_loc10_]["hiring_costs_per_level"][_loc3_]["resource"] = resourceNameIdMap.getValue(domainInfo["units"][_loc10_]["hiring_costs_per_level"][_loc3_]["resource"]);
                  _loc3_++;
               }
            }
            if("favourite_targets" in domainInfo["units"][_loc10_])
            {
               _loc8_ = 0;
               while(_loc8_ < domainInfo["units"][_loc10_]["favourite_targets"].length)
               {
                  domainInfo["units"][_loc10_]["favourite_targets"][_loc8_] = buildingKindNameIdMap.getValue(domainInfo["units"][_loc10_]["favourite_targets"][_loc8_]);
                  _loc8_++;
               }
            }
            if("unlock_costs" in domainInfo["units"][_loc10_])
            {
               _loc3_ = 0;
               while(_loc3_ < domainInfo["units"][_loc10_]["unlock_costs"].length)
               {
                  domainInfo["units"][_loc10_]["unlock_costs"][_loc3_]["name"] = resourceNameIdMap.getValue(domainInfo["units"][_loc10_]["unlock_costs"][_loc3_]["name"]);
                  _loc3_++;
               }
            }
            if("training_costs_per_Level" in domainInfo["units"][_loc10_])
            {
               _loc3_ = 0;
               while(_loc3_ < domainInfo["units"][_loc10_]["training_costs_per_Level"].length)
               {
                  domainInfo["units"][_loc10_]["training_costs_per_Level"][_loc3_]["resource"] = resourceNameIdMap.getValue(domainInfo["units"][_loc10_]["training_costs_per_Level"][_loc3_]["resource"]);
                  _loc3_++;
               }
            }
            if("training_prerequisites_per_level" in domainInfo["units"][_loc10_])
            {
               _loc8_ = 0;
               while(_loc8_ < domainInfo["units"][_loc10_]["training_prerequisites_per_level"].length)
               {
                  domainInfo["units"][_loc10_]["training_prerequisites_per_level"][_loc8_]["building"] = buildingNameIdMap.getValue(domainInfo["units"][_loc10_]["training_prerequisites_per_level"][_loc8_]["building"]);
                  _loc8_++;
               }
            }
            _loc10_++;
         }
         _loc6_ = 0;
         while(_loc6_ < domainInfo["beasts"].length)
         {
            domainInfo["beasts"][_loc6_]["prerequisite"]["building"] = buildingNameIdMap.getValue(domainInfo["beasts"][_loc6_]["prerequisite"]["building"]);
            if("favourite_targets" in domainInfo["beasts"][_loc6_])
            {
               _loc8_ = 0;
               while(_loc8_ < domainInfo["beasts"][_loc6_]["favourite_targets"].length)
               {
                  domainInfo["beasts"][_loc6_]["favourite_targets"][_loc8_] = buildingKindNameIdMap.getValue(domainInfo["beasts"][_loc6_]["favourite_targets"][_loc8_]);
                  _loc8_++;
               }
            }
            if("favourite_targets_for_max_level" in domainInfo["beasts"][_loc6_])
            {
               _loc8_ = 0;
               while(_loc8_ < domainInfo["beasts"][_loc6_]["favourite_targets_for_max_level"].length)
               {
                  domainInfo["beasts"][_loc6_]["favourite_targets_for_max_level"][_loc8_] = buildingKindNameIdMap.getValue(domainInfo["beasts"][_loc6_]["favourite_targets_for_max_level"][_loc8_]);
                  _loc8_++;
               }
            }
            if("training_costs_per_level" in domainInfo["beasts"][_loc6_])
            {
               _loc2_ = 0;
               while(_loc2_ < domainInfo["beasts"][_loc6_]["training_costs_per_level"].length)
               {
                  _loc10_ = 0;
                  while(_loc10_ < domainInfo["beasts"][_loc6_]["training_costs_per_level"][_loc2_]["unitNames"].length)
                  {
                     domainInfo["beasts"][_loc6_]["training_costs_per_level"][_loc2_]["unitNames"][_loc10_] = unitNameIdMap.getValue(domainInfo["beasts"][_loc6_]["training_costs_per_level"][_loc2_]["unitNames"][_loc10_]);
                     _loc10_++;
                  }
                  _loc2_++;
               }
            }
            if("training_costs_per_stage" in domainInfo["beasts"][_loc6_])
            {
               _loc2_ = 0;
               while(_loc2_ < domainInfo["beasts"][_loc6_]["training_costs_per_stage"].length)
               {
                  _loc10_ = 0;
                  while(_loc10_ < domainInfo["beasts"][_loc6_]["training_costs_per_stage"][_loc2_]["unitNames"].length)
                  {
                     domainInfo["beasts"][_loc6_]["training_costs_per_stage"][_loc2_]["unitNames"][_loc10_] = unitNameIdMap.getValue(domainInfo["beasts"][_loc6_]["training_costs_per_stage"][_loc2_]["unitNames"][_loc10_]);
                     _loc10_++;
                  }
                  _loc2_++;
               }
            }
            _loc6_++;
         }
         _loc5_ = 0;
         while(_loc5_ < domainInfo["catapults"].length)
         {
            _loc12_ = 0;
            while(_loc12_ < domainInfo["catapults"][_loc5_]["resource_costs"].length)
            {
               domainInfo["catapults"][_loc5_]["resource_costs"][_loc12_]["resource"] = resourceNameIdMap.getValue(domainInfo["catapults"][_loc5_]["resource_costs"][_loc12_]["resource"]);
               _loc12_++;
            }
            _loc5_++;
         }
      }
      
      private function preprocessVisualInfo() : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < visualInfo["buildings"].length)
         {
            if("build_menu_category" in visualInfo["buildings"][_loc3_])
            {
               visualInfo["buildings"][_loc3_]["build_menu_category"] = buildMenuCategoryNameIdMap.getValue(visualInfo["buildings"][_loc3_]["build_menu_category"]);
            }
            if("default_action_type" in visualInfo["buildings"][_loc3_])
            {
               visualInfo["buildings"][_loc3_]["default_action_type"] = actionTypeNameIdMap.getValue(visualInfo["buildings"][_loc3_]["default_action_type"]);
            }
            _loc2_ = 0;
            while(_loc2_ < visualInfo["buildings"][_loc3_]["visuals"].length)
            {
               if("layer" in visualInfo["buildings"][_loc3_]["visuals"][_loc2_])
               {
                  visualInfo["buildings"][_loc3_]["visuals"][_loc2_]["layer"] = layerNameIdMap.getValue(visualInfo["buildings"][_loc3_]["visuals"][_loc2_]["layer"]);
               }
               _loc2_++;
            }
            _loc3_++;
         }
         _loc1_ = 0;
         while(_loc1_ < visualInfo["decorations"].length)
         {
            if("build_menu_category" in visualInfo["decorations"][_loc1_])
            {
               visualInfo["decorations"][_loc1_]["build_menu_category"] = buildMenuCategoryNameIdMap.getValue(visualInfo["decorations"][_loc1_]["build_menu_category"]);
            }
            if("build_menu_decoration_category" in visualInfo["decorations"][_loc1_])
            {
               visualInfo["decorations"][_loc1_]["build_menu_decoration_category"] = buildMenuDecorationCategoryNameIdMap.getValue(visualInfo["decorations"][_loc1_]["build_menu_decoration_category"]);
            }
            _loc1_++;
         }
      }
      
      public function populateAllBuildings() : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc1_:Object = null;
         var _loc5_:Object = null;
         var _loc2_:BuildingTypeDIO = null;
         buildingMap = new Dictionary();
         buildingVector = new Vector.<BuildingTypeDIO>();
         _loc4_ = 0;
         while(_loc4_ < domainInfo["buildings"].length)
         {
            _loc1_ = domainInfo["buildings"][_loc4_];
            _loc3_ = 0;
            while(_loc3_ < visualInfo["buildings"].length)
            {
               _loc5_ = visualInfo["buildings"][_loc3_];
               if(_loc1_["id"] == _loc5_["id"])
               {
                  _loc2_ = populateBuilding(_loc1_,_loc5_);
                  buildingMap[_loc2_.id] = _loc2_;
                  buildingVector.push(_loc2_);
                  break;
               }
               _loc3_++;
            }
            _loc4_++;
         }
      }
      
      public function populateAllDecorations() : void
      {
         var _loc1_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:Object = null;
         var _loc4_:Object = null;
         var _loc2_:DecorationTypeDIO = null;
         decorationMap = new Dictionary();
         decorationVector = new Vector.<DecorationTypeDIO>();
         _loc1_ = 0;
         while(_loc1_ < domainInfo["decorations"].length)
         {
            _loc3_ = domainInfo["decorations"][_loc1_];
            _loc5_ = 0;
            while(_loc5_ < visualInfo["decorations"].length)
            {
               _loc4_ = visualInfo["decorations"][_loc5_];
               if(_loc3_["id"] == _loc4_["id"])
               {
                  _loc2_ = populateDecoration(_loc3_,_loc4_);
                  decorationMap[_loc2_.id] = _loc2_;
                  decorationVector.push(_loc2_);
                  break;
               }
               _loc5_++;
            }
            _loc1_++;
         }
      }
      
      public function populatePartBuildingMap() : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Object = null;
         var _loc1_:Object = null;
         var _loc6_:Object = null;
         partBuildingMap = new Dictionary();
         _loc3_ = 0;
         while(_loc3_ < domainInfo["parts"].length)
         {
            _loc5_ = domainInfo["parts"][_loc3_];
            _loc2_ = 0;
            while(_loc2_ < domainInfo["buildings"].length)
            {
               _loc1_ = domainInfo["buildings"][_loc2_];
               if("part_requirements" in _loc1_)
               {
                  _loc4_ = 0;
                  while(_loc4_ < _loc1_["part_requirements"].length)
                  {
                     _loc6_ = _loc1_["part_requirements"][_loc4_];
                     if(_loc6_["part"] == _loc5_["id"])
                     {
                        if(!partBuildingMap[_loc6_["part"]])
                        {
                           partBuildingMap[_loc6_["part"]] = new Vector.<int>();
                        }
                        (partBuildingMap[_loc6_["part"]] as Vector.<int>).push(_loc1_["id"]);
                        break;
                     }
                     _loc4_++;
                  }
               }
               _loc2_++;
            }
            _loc3_++;
         }
         var _loc7_:Vector.<int> = new Vector.<int>();
         _loc7_.push(-1);
         partBuildingMap[30] = _loc7_;
         partBuildingMap[31] = _loc7_;
         partBuildingMap[32] = _loc7_;
         partBuildingMap[33] = _loc7_;
      }
      
      public function populateAllParts() : void
      {
         var _loc3_:int = 0;
         var _loc4_:Object = null;
         var _loc2_:Object = null;
         var _loc5_:PartTypeDIO = null;
         partMap = new Dictionary();
         _loc3_ = 0;
         while(_loc3_ < domainInfo["parts"].length)
         {
            _loc4_ = domainInfo["parts"][_loc3_];
            _loc2_ = visualInfo["parts"][_loc3_];
            _loc5_ = populatePart(_loc4_,_loc2_,partBuildingMap[_loc4_["id"]],resourceNameIdMap);
            partMap[_loc5_.id] = _loc5_;
            _loc3_++;
         }
         for each(var _loc1_ in PartTypeDIO.gifts)
         {
            partMap[_loc1_.id] = _loc1_;
         }
      }
      
      public function populateAllUnits() : void
      {
         var _loc5_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:Object = null;
         var _loc3_:Object = null;
         var _loc1_:UnitTypeDIO = null;
         unitMap = new Dictionary();
         unitVector = new Vector.<UnitTypeDIO>();
         deprecatedUnitVector = new Vector.<UnitTypeDIO>();
         _loc5_ = 0;
         while(_loc5_ < domainInfo["units"].length)
         {
            _loc4_ = domainInfo["units"][_loc5_];
            _loc2_ = 0;
            while(_loc2_ < visualInfo["units"].length)
            {
               _loc3_ = visualInfo["units"][_loc2_];
               if(_loc4_["id"] == _loc3_["id"])
               {
                  _loc1_ = populateUnit(_loc4_,_loc3_);
                  unitMap[_loc1_.id] = _loc1_;
                  if(_loc1_.deprecated)
                  {
                     deprecatedUnitVector.push(_loc1_);
                  }
                  else
                  {
                     unitVector.push(_loc1_);
                  }
                  break;
               }
               _loc2_++;
            }
            _loc5_++;
         }
         unitVector.sort(onUnitSort);
         deprecatedUnitVector.sort(onUnitSort);
      }
      
      private function populateWorker() : void
      {
         var _loc3_:int = 0;
         var _loc7_:int = 0;
         var _loc1_:String = null;
         var _loc2_:* = undefined;
         var _loc8_:Object = visualInfo["worker"];
         var _loc12_:Object = domainInfo["worker"];
         var _loc5_:Point = new Point();
         var _loc4_:Vector.<int> = new Vector.<int>();
         var _loc11_:Vector.<Vector.<int>> = new Vector.<Vector.<int>>();
         if("asset_name" in _loc8_)
         {
            _loc1_ = _loc8_["asset_name"];
         }
         if("animation_sort_point" in _loc8_)
         {
            _loc5_.x = _loc8_["animation_sort_point"].x;
            _loc5_.y = _loc8_["animation_sort_point"].y;
         }
         if("movement_animation_speed" in _loc8_)
         {
            _loc3_ = int(_loc8_["movement_animation_speed"]);
         }
         if("work_animation_speed" in _loc8_)
         {
            _loc7_ = int(_loc8_["work_animation_speed"]);
         }
         if("base_cost_per_instance" in _loc12_)
         {
            for each(var _loc6_ in _loc12_["base_cost_per_instance"])
            {
               _loc4_.push(_loc6_);
            }
         }
         if("staff_gold_reductions_per_instance" in _loc12_)
         {
            for each(var _loc10_ in _loc12_["staff_gold_reductions_per_instance"])
            {
               _loc2_ = new Vector.<int>();
               for each(var _loc9_ in _loc10_)
               {
                  _loc2_.push(_loc9_);
               }
               _loc11_.push(_loc2_);
            }
         }
         _worker = new WorkerTypeDIO(_loc1_,_loc5_,_loc3_,_loc7_,_loc4_,_loc11_);
      }
      
      private function populateEventItems() : void
      {
         var _loc1_:int = 0;
         var _loc3_:Object = null;
         var _loc2_:EventItemDIO = null;
         _eventItemMap = new Dictionary();
         eventItemVector = new Vector.<EventItemDIO>();
         _loc1_ = 0;
         while(_loc1_ < visualInfo["event_items"].length)
         {
            _loc3_ = visualInfo["event_items"][_loc1_];
            _loc2_ = populateEventItem(_loc3_);
            if(_loc2_.relatedId != 32)
            {
               _eventItemMap[_loc2_.id] = _loc2_;
               eventItemVector.push(_loc2_);
            }
            _loc1_++;
         }
      }
      
      private function populateAllCatapults() : void
      {
         var _loc3_:int = 0;
         var _loc19_:Object = null;
         var _loc9_:int = 0;
         var _loc14_:String = null;
         var _loc21_:int = 0;
         var _loc17_:* = undefined;
         var _loc15_:* = undefined;
         var _loc12_:* = undefined;
         var _loc18_:* = undefined;
         var _loc11_:int = 0;
         var _loc10_:Number = NaN;
         var _loc5_:* = undefined;
         var _loc4_:* = undefined;
         var _loc6_:* = undefined;
         var _loc1_:CatapultTypeDIO = null;
         _catapultMap = new Dictionary();
         catapultVector = new Vector.<CatapultTypeDIO>();
         _loc3_ = 0;
         while(_loc3_ < domainInfo["catapults"].length)
         {
            _loc19_ = domainInfo["catapults"][_loc3_];
            _loc9_ = int(_loc19_["id"]);
            _loc14_ = _loc19_["name"];
            _loc21_ = int(_loc19_["max_stage"]);
            _loc17_ = new Vector.<int>();
            _loc15_ = new Vector.<Vector.<ResourceAmountDTO>>();
            _loc12_ = new Vector.<int>();
            _loc18_ = new Vector.<CatapultEffectTypeDTO>();
            for each(var _loc2_ in _loc19_["ranges_per_stage"])
            {
               _loc17_.push(int(_loc2_));
            }
            for each(var _loc13_ in _loc19_["activation_time_per_stage"])
            {
               _loc12_.push(int(_loc13_));
            }
            for each(var _loc8_ in _loc19_["resource_costs"])
            {
               _loc11_ = 0;
               for each(_loc10_ in _loc8_["amounts_per_level"])
               {
                  if(_loc11_ == _loc15_.length)
                  {
                     _loc5_ = new Vector.<ResourceAmountDTO>();
                     _loc15_.push(_loc5_);
                  }
                  else
                  {
                     _loc5_ = _loc15_[_loc11_];
                  }
                  _loc11_++;
                  _loc5_.push(new ResourceAmountDTO(_loc8_["resource"],_loc10_));
               }
            }
            for each(var _loc7_ in _loc19_["effect_values"])
            {
               _loc4_ = new Vector.<Number>();
               for each(var _loc16_ in _loc7_["values_per_stage"])
               {
                  _loc4_.push(Number(_loc16_));
               }
               _loc18_.push(new CatapultEffectTypeDTO(_loc7_["effect_type"] + "",_loc4_));
            }
            _loc6_ = new Vector.<int>();
            for each(var _loc20_ in _loc19_["upgrade_durations_per_level_in_secs"])
            {
               _loc6_.push(_loc20_);
            }
            _loc1_ = new CatapultTypeDIO(_loc9_,_loc14_,_loc21_,_loc17_,_loc15_,_loc12_,_loc18_,_loc6_);
            _catapultMap[_loc9_] = _loc1_;
            catapultVector.push(_loc1_);
            _loc3_++;
         }
      }
      
      private function populateFortifications() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Object = null;
         var _loc7_:String = null;
         var _loc4_:Point = null;
         var _loc5_:int = 0;
         var _loc6_:Point = null;
         var _loc3_:Point = null;
         _loc1_ = 0;
         while(_loc1_ < visualInfo["fortification_types"].length)
         {
            _loc2_ = visualInfo["fortification_types"][_loc1_];
            _loc7_ = _loc2_["size"];
            _loc4_ = new Point(_loc2_["default_offset"]["x"],_loc2_["default_offset"]["y"]);
            _loc5_ = 1;
            while(_loc5_ <= 4)
            {
               _loc6_ = _loc4_;
               _loc3_ = _loc4_;
               if("offset_per_stage" in _loc2_ && String(_loc5_) in _loc2_["offset_per_stage"])
               {
                  if("front_offset" in _loc2_["offset_per_stage"][String(_loc5_)])
                  {
                     _loc6_ = new Point(_loc2_["offset_per_stage"][String(_loc5_)]["front_offset"]["x"],_loc2_["offset_per_stage"][String(_loc5_)]["front_offset"]["y"]);
                  }
                  else if("default_offset" in _loc2_["offset_per_stage"][String(_loc5_)])
                  {
                     _loc6_ = new Point(_loc2_["offset_per_stage"][String(_loc5_)]["default_offset"]["x"],_loc2_["offset_per_stage"][String(_loc5_)]["default_offset"]["y"]);
                  }
                  if("back_offset" in _loc2_["offset_per_stage"][String(_loc5_)])
                  {
                     _loc3_ = new Point(_loc2_["offset_per_stage"][String(_loc5_)]["back_offset"]["x"],_loc2_["offset_per_stage"][String(_loc5_)]["back_offset"]["y"]);
                  }
                  else if("default_offset" in _loc2_["offset_per_stage"][String(_loc5_)])
                  {
                     _loc3_ = new Point(_loc2_["offset_per_stage"][String(_loc5_)]["default_offset"]["x"],_loc2_["offset_per_stage"][String(_loc5_)]["default_offset"]["y"]);
                  }
               }
               FortificationType.addFortificationType(_loc7_,_loc5_,"Front",_loc6_);
               FortificationType.addFortificationType(_loc7_,_loc5_,"Back",_loc3_);
               _loc5_++;
            }
            _loc1_++;
         }
      }
      
      private function populateScaffolds() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Object = null;
         var _loc5_:String = null;
         var _loc3_:Point = null;
         var _loc4_:Point = null;
         _loc1_ = 0;
         while(_loc1_ < visualInfo["scaffold_types"].length)
         {
            _loc2_ = visualInfo["scaffold_types"][_loc1_];
            _loc5_ = _loc2_["size"];
            _loc3_ = new Point(_loc2_["back_offset"]["x"],_loc2_["back_offset"]["y"]);
            _loc4_ = new Point(_loc2_["front_offset"]["x"],_loc2_["front_offset"]["y"]);
            ScaffoldType.addScaffoldType(_loc5_,"Front",_loc4_);
            ScaffoldType.addScaffoldType(_loc5_,"Back",_loc3_);
            _loc1_++;
         }
      }
      
      private function populateUnit(param1:Object, param2:Object) : UnitTypeDIO
      {
         var _loc31_:int = 0;
         var _loc21_:int = 0;
         var _loc16_:int = 0;
         var _loc6_:* = null;
         var _loc34_:* = undefined;
         var _loc45_:ResourceAmountDTO = null;
         var _loc17_:Boolean = false;
         var _loc46_:Boolean = false;
         var _loc11_:Boolean = false;
         var _loc19_:int = 0;
         var _loc25_:PrerequisiteDIO = null;
         var _loc28_:String = null;
         var _loc29_:int = 0;
         var _loc42_:int = 0;
         var _loc38_:Boolean = false;
         var _loc15_:int = int(param1["id"]);
         var _loc13_:Boolean = false;
         var _loc40_:Vector.<int> = new Vector.<int>();
         var _loc7_:Vector.<Number> = new Vector.<Number>();
         var _loc24_:Vector.<Number> = new Vector.<Number>();
         var _loc3_:Vector.<int> = new Vector.<int>();
         var _loc32_:Vector.<int> = new Vector.<int>();
         var _loc23_:Vector.<Vector.<ResourceAmountDTO>> = new Vector.<Vector.<ResourceAmountDTO>>();
         var _loc5_:Vector.<int> = new Vector.<int>();
         var _loc26_:Vector.<int> = new Vector.<int>();
         var _loc27_:Vector.<Vector.<ResourceAmountDTO>> = new Vector.<Vector.<ResourceAmountDTO>>();
         var _loc36_:Vector.<int> = new Vector.<int>();
         var _loc4_:Vector.<PrerequisiteDIO> = new Vector.<PrerequisiteDIO>();
         var _loc18_:Number = 0;
         var _loc35_:int = int(param1["max_levels"]);
         var _loc8_:Vector.<int> = new Vector.<int>();
         var _loc12_:Vector.<int> = new Vector.<int>();
         var _loc33_:Vector.<int> = new Vector.<int>();
         var _loc9_:Number = 0;
         var _loc22_:Boolean = false;
         var _loc44_:Boolean = false;
         var _loc30_:Boolean = false;
         var _loc39_:Dictionary = extractUnitSpecificInfo(param1,param2);
         if("barracks_gold_costs_per_level" in param1)
         {
            _loc31_ = 0;
            while(_loc31_ < param1["barracks_gold_costs_per_level"].length)
            {
               _loc8_.push(param1["barracks_gold_costs_per_level"][_loc31_]);
               _loc31_++;
            }
         }
         if("watch_post_gold_costs_per_level" in param1)
         {
            _loc31_ = 0;
            while(_loc31_ < param1["watch_post_gold_costs_per_level"].length)
            {
               _loc12_.push(param1["watch_post_gold_costs_per_level"][_loc31_]);
               _loc31_++;
            }
         }
         if("flying" in param1)
         {
            _loc17_ = Boolean(param1["flying"]);
         }
         if("mastery" in param1)
         {
            _loc44_ = Boolean(param1["mastery"]);
         }
         if("ranges_per_level" in param1)
         {
            _loc31_ = 0;
            while(_loc31_ < param1["ranges_per_level"].length)
            {
               _loc33_.push(param1["ranges_per_level"][_loc31_]);
               _loc31_++;
            }
         }
         if("splash_range" in param1)
         {
            _loc9_ = Number(param1["splash_range"]);
         }
         if("underground" in param1)
         {
            _loc46_ = Boolean(param1["underground"]);
         }
         if("healer" in param1)
         {
            _loc11_ = Boolean(param1["healer"]);
         }
         if("unlock_duration_in_secs" in param1)
         {
            _loc18_ = Number(param1["unlock_duration_in_secs"]);
         }
         if("targets_anything" in param1)
         {
            _loc13_ = Boolean(param1["targets_anything"]);
         }
         if("favourite_targets" in param1)
         {
            _loc31_ = 0;
            while(_loc31_ < param1["favourite_targets"].length)
            {
               _loc40_.push(param1["favourite_targets"][_loc31_]);
               _loc31_++;
            }
         }
         if("unlock_costs" in param1 && param1["unlock_costs"].length > 0)
         {
            _loc45_ = new ResourceAmountDTO(param1["unlock_costs"][0]["name"],param1["unlock_costs"][0]["amount"]);
         }
         else
         {
            _loc45_ = new ResourceAmountDTO(0,0);
         }
         if("unlock_prerequisite" in param1)
         {
            _loc25_ = new PrerequisiteDIO(param1["unlock_prerequisite"]["building"],param1["unlock_prerequisite"]["level"]);
         }
         if("speeds_per_level" in param1)
         {
            _loc31_ = 0;
            while(_loc31_ < param1["speeds_per_level"].length)
            {
               _loc7_.push(param1["speeds_per_level"][_loc31_]);
               _loc24_.push(param1["speeds_per_level"][_loc31_] * _constants.yardUnitPerSecond / 60);
               _loc31_++;
            }
         }
         if("health_points_per_level" in param1)
         {
            _loc31_ = 0;
            while(_loc31_ < param1["health_points_per_level"].length)
            {
               _loc3_.push(param1["health_points_per_level"][_loc31_]);
               _loc31_++;
            }
         }
         if("damage_points_per_level" in param1)
         {
            _loc31_ = 0;
            while(_loc31_ < param1["damage_points_per_level"].length)
            {
               _loc32_.push(param1["damage_points_per_level"][_loc31_]);
               _loc31_++;
            }
         }
         if("hiring_costs_per_level" in param1)
         {
            for each(_loc6_ in param1["hiring_costs_per_level"])
            {
               _loc21_ = 0;
               for each(_loc16_ in _loc6_["amounts_per_level"])
               {
                  if(_loc21_ == _loc23_.length)
                  {
                     _loc34_ = new Vector.<ResourceAmountDTO>();
                     _loc23_.push(_loc34_);
                  }
                  else
                  {
                     _loc34_ = _loc23_[_loc21_];
                  }
                  _loc21_++;
                  _loc34_.push(new ResourceAmountDTO(_loc6_["resource"],_loc16_));
               }
            }
         }
         else
         {
            _loc31_ = 0;
            while(_loc31_ < _loc35_)
            {
               _loc23_.push(new Vector.<ResourceAmountDTO>());
               _loc31_++;
            }
         }
         if("hiring_durations_per_level_in_secs" in param1)
         {
            _loc31_ = 0;
            while(_loc31_ < param1["hiring_durations_per_level_in_secs"].length)
            {
               _loc5_.push(param1["hiring_durations_per_level_in_secs"][_loc31_]);
               _loc31_++;
            }
         }
         if("spaces_per_level" in param1)
         {
            _loc31_ = 0;
            while(_loc31_ < param1["spaces_per_level"].length)
            {
               _loc26_.push(param1["spaces_per_level"][_loc31_]);
               _loc31_++;
            }
         }
         if("training_costs_per_Level" in param1)
         {
            for each(_loc6_ in param1["training_costs_per_Level"])
            {
               _loc21_ = 0;
               for each(_loc16_ in _loc6_["amounts_per_level"])
               {
                  if(_loc21_ == _loc27_.length)
                  {
                     _loc34_ = new Vector.<ResourceAmountDTO>();
                     _loc27_.push(_loc34_);
                  }
                  else
                  {
                     _loc34_ = _loc27_[_loc21_];
                  }
                  _loc21_++;
                  _loc34_.push(new ResourceAmountDTO(_loc6_["resource"],_loc16_));
               }
            }
         }
         else
         {
            _loc31_ = 0;
            while(_loc31_ < _loc35_)
            {
               _loc27_.push(new Vector.<ResourceAmountDTO>());
               _loc31_++;
            }
         }
         if("training_durations_per_level_in_secs" in param1)
         {
            _loc31_ = 0;
            while(_loc31_ < param1["training_durations_per_level_in_secs"].length)
            {
               _loc36_.push(param1["training_durations_per_level_in_secs"][_loc31_]);
               _loc31_++;
            }
         }
         if("training_prerequisites_per_level" in param1)
         {
            _loc31_ = 0;
            while(_loc31_ < param1["training_prerequisites_per_level"].length)
            {
               _loc4_.push(new PrerequisiteDIO(param1["training_prerequisites_per_level"][_loc31_]["building"],param1["training_prerequisites_per_level"][_loc31_]["level"]));
               _loc31_++;
            }
         }
         if("event" in param1)
         {
            _loc22_ = true;
         }
         if("team_size" in param1)
         {
            _loc19_ = int(param1["team_size"]);
         }
         if("deprecated" in param1)
         {
            _loc30_ = Boolean(param1["deprecated"]);
         }
         var _loc20_:Point = new Point();
         var _loc14_:int = 0;
         var _loc41_:String = "";
         var _loc10_:Boolean = false;
         var _loc43_:String = null;
         var _loc37_:Point = new Point();
         if("index" in param2)
         {
            _loc14_ = int(param2["index"]);
         }
         if("asset_name" in param2)
         {
            _loc28_ = param2["asset_name"];
         }
         if("animation_sort_point" in param2)
         {
            _loc20_.x = param2["animation_sort_point"].x;
            _loc20_.y = param2["animation_sort_point"].y;
         }
         if("movement_animation_speed" in param2)
         {
            _loc29_ = int(param2["movement_animation_speed"]);
         }
         if("attack_animation_speed" in param2)
         {
            _loc42_ = int(param2["attack_animation_speed"]);
         }
         if("animation_loop" in param2)
         {
            _loc38_ = Boolean(param2["animation_loop"]);
         }
         if("particle_asset" in param2)
         {
            _loc41_ = param2["particle_asset"];
         }
         if("particle_rotate" in param2)
         {
            _loc10_ = Boolean(param2["particle_rotate"]);
         }
         if("particle_sound" in param2)
         {
            _loc43_ = param2["particle_sound"];
         }
         if("offset1" in param2)
         {
            _loc37_.x = param2["offset1"].x;
            _loc37_.y = param2["offset1"].y;
         }
         return new UnitTypeDIO(_loc15_,_loc13_,_loc40_,_loc25_,_loc45_,_loc18_,_loc7_,_loc24_,_loc3_,_loc32_,_loc23_,_loc5_,_loc26_,_loc27_,_loc36_,_loc4_,_loc35_,_loc8_,_loc12_,_loc28_,_loc20_,_loc29_,_loc42_,_loc17_,_loc38_,_loc14_,_loc33_,_loc9_,_loc46_,_loc11_,_loc22_,_loc44_,_loc39_,_loc19_,_loc41_,_loc10_,_loc43_,_loc30_,_loc37_);
      }
      
      private function extractUnitSpecificInfo(param1:Object, param2:Object) : Dictionary
      {
         var _loc8_:* = undefined;
         var _loc4_:* = undefined;
         var _loc3_:* = undefined;
         var _loc6_:Dictionary = new Dictionary();
         if("splash_per_mastery" in param1)
         {
            _loc8_ = new Vector.<int>();
            for each(var _loc7_ in param1["splash_per_mastery"])
            {
               _loc8_.push(_loc7_);
            }
            _loc6_[UnitSpecificInfoType.SPLASH_PER_MASTERY.id] = _loc8_;
         }
         if("ranges_per_mastery" in param1)
         {
            _loc4_ = new Vector.<int>();
            for each(var _loc5_ in param1["ranges_per_mastery"])
            {
               _loc4_.push(_loc5_);
            }
            _loc6_[UnitSpecificInfoType.RANGES_PER_MASTERY.id] = _loc4_;
         }
         if("cloak_per_mastery" in param1)
         {
            _loc3_ = new Vector.<int>();
            for each(var _loc9_ in param1["cloak_per_mastery"])
            {
               _loc3_.push(_loc9_);
            }
            _loc6_[UnitSpecificInfoType.CLOAK_PER_MASTERY.id] = _loc3_;
         }
         return _loc6_;
      }
      
      private function populateDecoration(param1:Object, param2:Object) : DecorationTypeDIO
      {
         var _loc7_:ConstructableKindTypeDIO = null;
         var _loc8_:int = int(param1["id"]);
         var _loc13_:Point = new Point();
         var _loc10_:String = "";
         var _loc11_:BuildMenuDecorationCategory = BuildMenuDecorationCategory.UNKNOWN;
         var _loc6_:Vector.<String> = null;
         var _loc12_:int = 0;
         var _loc4_:int = 0;
         var _loc9_:Boolean = true;
         var _loc5_:Point = new Point();
         if("mobile_ui_offset" in param2)
         {
            _loc5_ = new Point(param2["mobile_ui_offset"]["x"],param2["mobile_ui_offset"]["y"]);
         }
         if("kind" in param1)
         {
            _loc7_ = getConstructableKind(param1.kind);
         }
         if("build_menu_decoration_category" in param2)
         {
            _loc11_ = BuildMenuDecorationCategory.getCategory(param2["build_menu_decoration_category"]);
         }
         if("sub_types" in param1)
         {
            _loc6_ = new Vector.<String>();
            for each(var _loc3_ in param1["sub_types"])
            {
               _loc6_.push(_loc3_);
            }
         }
         if("buying_gold_price" in param1)
         {
            _loc12_ = int(param1["buying_gold_price"]);
         }
         if("buying_rp_price" in param1)
         {
            _loc12_ = int(param1["buying_rp_price"]);
            _loc9_ = false;
         }
         if("selling_rp_price" in param1)
         {
            _loc4_ = int(param1["selling_rp_price"]);
         }
         if("offset" in param2)
         {
            _loc13_.x = param2["offset"]["x"];
            _loc13_.y = param2["offset"]["y"];
         }
         if("planner_icon" in param2)
         {
            _loc10_ = param2["planner_icon"];
         }
         return new DecorationTypeDIO(_loc8_,getConstructableKind(31),param1["base_size"],_loc11_,_loc6_,param2["visual"],_loc12_,_loc4_,_loc9_,_loc13_,_loc10_,_loc5_);
      }
      
      private function populateBuilding(param1:Object, param2:Object) : BuildingTypeDIO
      {
         var _loc70_:int = 0;
         var _loc99_:int = 0;
         var _loc73_:int = 0;
         var _loc3_:Point = null;
         var _loc52_:Point = null;
         var _loc5_:Point = null;
         var _loc108_:int = 0;
         var _loc35_:int = 0;
         var _loc97_:String = null;
         var _loc72_:String = null;
         var _loc44_:Boolean = false;
         var _loc88_:Boolean = false;
         var _loc6_:* = undefined;
         var _loc107_:int = 0;
         var _loc101_:int = 0;
         var _loc93_:Point = null;
         var _loc14_:Point = null;
         var _loc8_:String = null;
         var _loc34_:Point = null;
         var _loc31_:Point = null;
         var _loc51_:int = 0;
         var _loc74_:int = 0;
         var _loc94_:String = null;
         var _loc78_:BuildingTypeVisual = null;
         var _loc38_:ConstructableKindTypeDIO = null;
         var _loc71_:int = 0;
         var _loc68_:Number = NaN;
         var _loc20_:* = undefined;
         var _loc58_:int = 0;
         var _loc76_:int = 0;
         var _loc24_:* = undefined;
         var _loc50_:* = undefined;
         var _loc41_:* = undefined;
         var _loc59_:* = undefined;
         var _loc96_:* = undefined;
         var _loc29_:* = undefined;
         var _loc79_:int = 0;
         var _loc64_:* = undefined;
         var _loc56_:* = undefined;
         var _loc15_:* = undefined;
         var _loc36_:* = undefined;
         var _loc69_:* = undefined;
         var _loc102_:* = undefined;
         var _loc98_:* = undefined;
         var _loc100_:* = undefined;
         var _loc12_:* = undefined;
         var _loc77_:* = undefined;
         var _loc17_:* = undefined;
         var _loc103_:* = undefined;
         var _loc30_:int = 0;
         var _loc61_:int = 0;
         var _loc83_:* = undefined;
         var _loc4_:Array = null;
         var _loc16_:Array = null;
         var _loc91_:* = undefined;
         var _loc89_:* = undefined;
         var _loc26_:* = undefined;
         var _loc11_:Array = null;
         var _loc46_:* = undefined;
         var _loc45_:* = undefined;
         var _loc65_:* = undefined;
         var _loc92_:int = int(param1["id"]);
         var _loc28_:Dictionary = new Dictionary();
         var _loc18_:ActionType = ActionType.ARROW;
         var _loc27_:Boolean = true;
         var _loc105_:String = "";
         var _loc86_:BuildMenuCategory = BuildMenuCategory.getCategory(0);
         var _loc7_:Boolean = false;
         var _loc67_:Vector.<int> = new Vector.<int>();
         var _loc90_:int = 1;
         var _loc81_:int = 3;
         var _loc104_:Array = [];
         var _loc13_:Array = [];
         var _loc22_:Boolean = false;
         var _loc109_:Boolean = Boolean(param2.multibuild);
         var _loc62_:int = 1;
         var _loc57_:String = "";
         var _loc85_:String = "B" + _loc92_ + "BuildMenu";
         var _loc9_:int = 0;
         var _loc80_:Point = new Point();
         if("mobile_ui_offset" in param2)
         {
            _loc80_ = new Point(param2["mobile_ui_offset"]["x"],param2["mobile_ui_offset"]["y"]);
         }
         if("fortification_size" in param2)
         {
            _loc57_ = param2["fortification_size"];
         }
         if("default_action_type" in param2)
         {
            _loc18_ = ActionType.getActionType(param2["default_action_type"]);
         }
         if("have_soil" in param2)
         {
            _loc27_ = Boolean(param2["have_soil"]);
         }
         if("planner_icon" in param2)
         {
            _loc105_ = param2["planner_icon"];
         }
         if("build_menu_category" in param2)
         {
            _loc86_ = BuildMenuCategory.getCategory(param2["build_menu_category"]);
         }
         if("defaults" in param2)
         {
            if("offset" in param2["defaults"])
            {
               _loc52_ = new Point(param2["defaults"]["offset"]["x"],param2["defaults"]["offset"]["y"]);
            }
            if("sort_point" in param2["defaults"])
            {
               _loc5_ = new Point(param2["defaults"]["sort_point"]["x"],param2["defaults"]["sort_point"]["y"]);
            }
            if("visual_stages_per_level" in param2["defaults"])
            {
               for each(_loc108_ in param2["defaults"]["visual_stages_per_level"])
               {
                  _loc67_.push(_loc108_);
                  _loc97_ = _loc108_ == 0 ? "" : "S" + _loc108_;
                  _loc72_ = "B" + _loc92_ + _loc97_ + "Silhouette";
                  _loc13_.push(_loc72_);
               }
            }
            if("animation_not_loop" in param2["defaults"])
            {
               _loc22_ = Boolean(param2["defaults"]["animation_not_loop"]);
            }
         }
         for each(var _loc47_ in param2["visuals"])
         {
            _loc44_ = false;
            _loc88_ = false;
            _loc6_ = _loc67_;
            _loc107_ = _loc90_;
            _loc101_ = _loc81_;
            _loc93_ = _loc52_;
            _loc14_ = _loc5_;
            _loc8_ = _loc47_["visual_type"];
            if("visual_stages_per_level" in _loc47_)
            {
               _loc6_ = new Vector.<int>();
               for each(_loc108_ in _loc47_["visual_stages_per_level"])
               {
                  _loc6_.push(_loc108_);
               }
            }
            if("layer" in _loc47_)
            {
               _loc101_ = int(_loc47_["layer"]);
            }
            if("main_visual" in _loc47_)
            {
               _loc44_ = Boolean(_loc47_["main_visual"]);
            }
            if("main_visual_front" in _loc47_)
            {
               _loc88_ = Boolean(_loc47_["main_visual_front"]);
            }
            if("visual_state" in _loc47_)
            {
               _loc107_ = int(_loc47_["visual_state"]);
            }
            if("offset" in _loc47_)
            {
               _loc93_ = new Point(_loc47_["offset"]["x"],_loc47_["offset"]["y"]);
            }
            if("sort_point" in _loc47_)
            {
               _loc14_ = new Point(_loc47_["sort_point"]["x"],_loc47_["sort_point"]["y"]);
            }
            _loc35_ = 0;
            while(_loc35_ < _loc6_.length)
            {
               if(!_loc104_[_loc35_])
               {
                  _loc104_[_loc35_] = [];
               }
               if(!_loc104_[_loc35_][_loc107_])
               {
                  _loc104_[_loc35_][_loc107_] = [];
               }
               _loc97_ = _loc6_[_loc35_] == 0 ? "" : "S" + _loc6_[_loc35_];
               _loc34_ = _loc93_;
               _loc31_ = _loc14_;
               _loc51_ = 0;
               _loc74_ = 0;
               if("info_per_visual_stage" in _loc47_ && _loc6_[_loc35_] + "" in _loc47_["info_per_visual_stage"])
               {
                  if("offset" in _loc47_["info_per_visual_stage"][_loc6_[_loc35_]])
                  {
                     _loc34_ = new Point(_loc47_["info_per_visual_stage"][_loc6_[_loc35_]]["offset"].x,_loc47_["info_per_visual_stage"][_loc6_[_loc35_]]["offset"].y);
                  }
                  if("sort_point" in _loc47_["info_per_visual_stage"][_loc6_[_loc35_]])
                  {
                     _loc31_ = new Point(_loc47_["info_per_visual_stage"][_loc6_[_loc35_]]["sort_point"].x,_loc47_["info_per_visual_stage"][_loc6_[_loc35_]]["sort_point"].y);
                  }
                  if("fps_change_rate" in _loc47_["info_per_visual_stage"][_loc6_[_loc35_]])
                  {
                     _loc51_ = int(_loc47_["info_per_visual_stage"][_loc6_[_loc35_]]["fps_change_rate"]);
                  }
                  if("frame_width" in _loc47_["info_per_visual_stage"][_loc6_[_loc35_]])
                  {
                     _loc74_ = int(_loc47_["info_per_visual_stage"][_loc6_[_loc35_]]["frame_width"]);
                  }
               }
               if("info_per_level" in _loc47_ && _loc35_ + 1 + "" in _loc47_["info_per_level"])
               {
                  if("offset" in _loc47_["info_per_level"][_loc35_ + 1 + ""])
                  {
                     _loc34_ = new Point(_loc47_["info_per_level"][_loc35_ + 1 + ""]["offset"].x,_loc47_["info_per_level"][_loc35_ + 1 + ""]["offset"].y);
                  }
                  if("sort_point" in _loc47_["info_per_level"][_loc35_ + 1 + ""])
                  {
                     _loc31_ = new Point(_loc47_["info_per_level"][_loc35_ + 1 + ""]["sort_point"].x,_loc47_["info_per_level"][_loc35_ + 1 + ""]["sort_point"].y);
                  }
                  if("fps_change_rate" in _loc47_["info_per_level"][_loc35_ + 1 + ""])
                  {
                     _loc51_ = int(_loc47_["info_per_level"][_loc35_ + 1 + ""]["fps_change_rate"]);
                  }
                  if("frame_width" in _loc47_["info_per_level"][_loc35_ + 1 + ""])
                  {
                     _loc74_ = int(_loc47_["info_per_level"][_loc35_ + 1 + ""]["frame_width"]);
                  }
               }
               _loc94_ = "B" + _loc92_ + _loc97_ + _loc8_;
               if("image" in _loc47_)
               {
                  _loc94_ = _loc47_["image"];
               }
               _loc78_ = new BuildingTypeVisual(_loc94_,_loc34_,_loc101_,_loc44_,_loc88_,_loc31_,_loc8_,_loc74_,_loc51_);
               _loc104_[_loc35_][_loc107_].push(_loc78_);
               _loc35_++;
            }
         }
         if("build_menu_index" in param2)
         {
            _loc9_ = int(param2["build_menu_index"]);
         }
         var _loc106_:Vector.<Vector.<ResourceAmountDTO>> = new Vector.<Vector.<ResourceAmountDTO>>();
         var _loc87_:Vector.<Number> = new Vector.<Number>();
         var _loc32_:Vector.<Number> = new Vector.<Number>();
         var _loc66_:Vector.<Number> = new Vector.<Number>();
         var _loc75_:Vector.<Vector.<PrerequisiteDIO>> = new Vector.<Vector.<PrerequisiteDIO>>();
         var _loc95_:Vector.<Vector.<PrerequisiteDIO>> = new Vector.<Vector.<PrerequisiteDIO>>();
         var _loc25_:Vector.<MultipleInstancePrerequisitesDIO> = new Vector.<MultipleInstancePrerequisitesDIO>();
         var _loc53_:Boolean = true;
         var _loc55_:Boolean = false;
         if("damage" in param1)
         {
            _loc28_[BuildingSpecificInfoType.DAMAGE.id] = param1["damage"];
         }
         if("produced_resource" in param1)
         {
            _loc28_[BuildingSpecificInfoType.PRODUCED_RESOURCE.id] = ResourceType.determineResourceType(param1["produced_resource"]);
         }
         if("fortification_info" in param1)
         {
            _loc28_[BuildingSpecificInfoType.FORTIFICATION_INFO.id] = populateFortificationInfoDIO(param1["fortification_info"]);
         }
         if("path_margin" in param1)
         {
            _loc62_ = int(param1["path_margin"]);
         }
         if("combine_building" in param1)
         {
            _loc7_ = Boolean(param1["combine_building"]);
            if("coordinates" in param1)
            {
               if("edge_space" in param1["coordinates"])
               {
                  _loc70_ = int(param1["coordinates"]["edge_space"]);
               }
               if("garden_space" in param1["coordinates"])
               {
                  _loc99_ = int(param1["coordinates"]["garden_space"]);
               }
               if("building_space" in param1["coordinates"])
               {
                  _loc73_ = int(param1["coordinates"]["building_space"]);
               }
               if("gate_coord" in param1["coordinates"])
               {
                  _loc3_ = new Point(param1["coordinates"]["gate_coord"]["x"],param1["coordinates"]["gate_coord"]["y"]);
               }
            }
         }
         if("kind" in param1)
         {
            _loc38_ = getConstructableKind(param1.kind);
         }
         if("recyclable" in param1)
         {
            _loc53_ = Boolean(param1["recyclable"]);
         }
         for each(var _loc54_ in param1["resource_costs"])
         {
            _loc71_ = 0;
            for each(_loc68_ in _loc54_["amounts_per_level"])
            {
               if(_loc71_ == _loc106_.length)
               {
                  _loc20_ = new Vector.<ResourceAmountDTO>();
                  _loc106_.push(_loc20_);
               }
               else
               {
                  _loc20_ = _loc106_[_loc71_];
               }
               _loc71_++;
               _loc20_.push(new ResourceAmountDTO(_loc54_["resource"],_loc68_));
            }
         }
         for each(var _loc48_ in param1["upgrade_durations_per_level_in_secs"])
         {
            _loc87_.push(_loc48_);
         }
         if("health_points_per_level" in param1)
         {
            for each(var _loc23_ in param1["health_points_per_level"])
            {
               _loc32_.push(_loc23_);
            }
         }
         else
         {
            _loc58_ = int(param1["max_levels"] ? param1["max_levels"] : 1);
            _loc76_ = 0;
            while(_loc76_ < _loc58_)
            {
               _loc32_.push(-1);
               _loc76_++;
            }
            _loc55_ = true;
         }
         var _loc49_:int = 3600;
         for each(var _loc21_ in param1["repair_durations_per_level_in_secs"])
         {
            _loc66_.push(_loc21_ > _loc49_ ? _loc49_ : _loc21_);
         }
         if("building_prerequisites_per_level" in param1)
         {
            for each(var _loc42_ in param1["building_prerequisites_per_level"])
            {
               _loc24_ = new Vector.<PrerequisiteDIO>();
               for each(var _loc39_ in _loc42_)
               {
                  _loc24_.push(new PrerequisiteDIO(_loc39_["building"],_loc39_["level"],_loc39_["count"]));
               }
               _loc95_.push(_loc24_);
            }
         }
         else
         {
            _loc71_ = 0;
            while(_loc71_ < param1["max_levels"])
            {
               _loc95_.push(new Vector.<PrerequisiteDIO>());
               _loc71_++;
            }
         }
         if("building_prerequisites_per_instance" in param1)
         {
            for each(var _loc43_ in param1["building_prerequisites_per_instance"])
            {
               _loc50_ = new Vector.<PrerequisiteDIO>();
               for each(var _loc84_ in _loc43_)
               {
                  _loc50_.push(new PrerequisiteDIO(_loc84_["building"],_loc84_["level"],_loc84_["count"]));
               }
               _loc75_.push(_loc50_);
            }
         }
         else
         {
            _loc76_ = 0;
            while(_loc76_ < param1["max_instances"])
            {
               _loc75_.push(new Vector.<PrerequisiteDIO>());
               _loc76_++;
            }
         }
         if("multiple_instance_prerequisites" in param1)
         {
            for each(var _loc40_ in param1["multiple_instance_prerequisites"])
            {
               _loc41_ = new Vector.<PrerequisiteDIO>();
               for each(var _loc10_ in _loc40_["prerequisites"])
               {
                  _loc41_.push(new PrerequisiteDIO(_loc10_["building"],_loc10_["level"]));
               }
               _loc25_.push(new MultipleInstancePrerequisitesDIO(_loc41_,_loc40_["max_instances"]));
            }
         }
         if("part_requirements" in param1)
         {
            _loc59_ = new Vector.<Vector.<PartInfoDTO>>();
            for each(var _loc60_ in param1["part_requirements"])
            {
               _loc71_ = 0;
               for each(_loc68_ in _loc60_["amounts_per_instance"])
               {
                  if(_loc71_ == _loc59_.length)
                  {
                     _loc96_ = new Vector.<PartInfoDTO>();
                     _loc59_.push(_loc96_);
                  }
                  else
                  {
                     _loc96_ = _loc59_[_loc71_];
                  }
                  _loc71_++;
                  var _temp_10:* = _loc96_;
                  var _temp_9:* = §§findproperty(PartInfoDTO);
                  var _temp_8:* = _loc60_["part"];
                  var _loc152_:String = "domain.parts." + _loc60_["part"] + ".name2";
                  _temp_10.push(new PartInfoDTO(_temp_8,peak.i18n.PText.INSTANCE.getText0(_loc152_),_loc68_));
               }
            }
            _loc28_[BuildingSpecificInfoType.PART_REQUIREMENTS_PER_LEVEL.id] = _loc59_;
         }
         if("storage_capacities_per_level" in param1)
         {
            _loc29_ = new Vector.<int>();
            _loc79_ = 0;
            while(_loc79_ < param1["storage_capacities_per_level"].length)
            {
               _loc29_.push(param1["storage_capacities_per_level"][_loc79_]);
               _loc79_++;
            }
            _loc28_[BuildingSpecificInfoType.STORAGE_CAPACITIES_PER_LEVEL.id] = _loc29_;
         }
         if("production_amounts_per_hour_per_level" in param1)
         {
            _loc64_ = new Vector.<int>();
            _loc79_ = 0;
            while(_loc79_ < param1["production_amounts_per_hour_per_level"].length)
            {
               _loc64_.push(param1["production_amounts_per_hour_per_level"][_loc79_]);
               _loc79_++;
            }
            _loc28_[BuildingSpecificInfoType.PRODUCTION_AMOUNTS_PER_HOUR_PER_LEVEL.id] = _loc64_;
         }
         if("mercenary_capacities_per_level" in param1)
         {
            _loc56_ = new Vector.<int>();
            _loc79_ = 0;
            while(_loc79_ < param1["mercenary_capacities_per_level"].length)
            {
               _loc56_.push(param1["mercenary_capacities_per_level"][_loc79_]);
               _loc79_++;
            }
            _loc28_[BuildingSpecificInfoType.MERCENARY_CAPACITIES_PER_LEVEL.id] = _loc56_;
         }
         if("musk_capacities_per_level" in param1)
         {
            _loc15_ = new Vector.<int>();
            _loc79_ = 0;
            while(_loc79_ < param1["musk_capacities_per_level"].length)
            {
               _loc15_.push(param1["musk_capacities_per_level"][_loc79_]);
               _loc79_++;
            }
            _loc28_[BuildingSpecificInfoType.MUSK_CAPACITIES_PER_LEVEL.id] = _loc15_;
         }
         if("musk_prices_per_level" in param1)
         {
            _loc36_ = new Vector.<int>();
            _loc79_ = 0;
            while(_loc79_ < param1["musk_prices_per_level"].length)
            {
               _loc36_.push(param1["musk_prices_per_level"][_loc79_]);
               _loc79_++;
            }
            _loc28_[BuildingSpecificInfoType.MUSK_PRICES_PER_LEVEL.id] = _loc36_;
         }
         if("gold_costs_per_slot" in param1)
         {
            _loc69_ = new Vector.<int>();
            _loc79_ = 0;
            while(_loc79_ < param1["gold_costs_per_slot"].length)
            {
               _loc69_.push(param1["gold_costs_per_slot"][_loc79_]);
               _loc79_++;
            }
            _loc28_[BuildingSpecificInfoType.GOLD_COSTS_PER_PLANNER_SAVE_SLOT.id] = _loc69_;
         }
         if("rp_costs_per_slot" in param1)
         {
            _loc102_ = new Vector.<int>();
            _loc79_ = 0;
            while(_loc79_ < param1["rp_costs_per_slot"].length)
            {
               _loc102_.push(param1["rp_costs_per_slot"][_loc79_]);
               _loc79_++;
            }
            _loc28_[BuildingSpecificInfoType.RP_COSTS_PER_PLANNER_SAVE_SLOT.id] = _loc102_;
         }
         if("ranges_per_level_in_px" in param1)
         {
            _loc98_ = new Vector.<Number>();
            for each(var _loc33_ in param1["ranges_per_level_in_px"])
            {
               _loc98_.push(_loc33_);
            }
            _loc28_[BuildingSpecificInfoType.RANGES_PER_LEVEL_IN_PX.id] = _loc98_;
         }
         if("damages_per_shot_per_level" in param1)
         {
            _loc100_ = new Vector.<Number>();
            for each(var _loc82_ in param1["damages_per_shot_per_level"])
            {
               _loc100_.push(_loc82_);
            }
            _loc28_[BuildingSpecificInfoType.DAMAGES_PER_SHOT_PER_LEVEL.id] = _loc100_;
         }
         if("attacks_air" in param1)
         {
            _loc28_[BuildingSpecificInfoType.ATTACKS_AIR.id] = param1["attacks_air"];
         }
         if("attacks_ground" in param1)
         {
            _loc28_[BuildingSpecificInfoType.ATTACKS_GROUND.id] = param1["attacks_ground"];
         }
         if("explosion_ranges_per_level_in_px" in param1)
         {
            _loc12_ = new Vector.<Number>();
            for each(var _loc37_ in param1["explosion_ranges_per_level_in_px"])
            {
               _loc12_.push(_loc37_);
            }
            _loc28_[BuildingSpecificInfoType.EXPLOSION_RANGES_PER_LEVEL_IN_PX.id] = _loc12_;
         }
         if("shots_fired_per_charge_per_level" in param1)
         {
            _loc77_ = new Vector.<Number>();
            for each(var _loc63_ in param1["shots_fired_per_charge_per_level"])
            {
               _loc77_.push(_loc63_);
            }
            _loc28_[BuildingSpecificInfoType.SHOTS_FIRED_PER_CHARGE_PER_LEVEL.id] = _loc77_;
         }
         if("reload_time_in_secs" in param1)
         {
            _loc28_[BuildingSpecificInfoType.RELOAD_TIME_IN_SECS.id] = param1["reload_time_in_secs"];
         }
         if("shots_per_second_per_level" in param1)
         {
            _loc17_ = new Vector.<Number>();
            for each(var _loc19_ in param1["shots_per_second_per_level"])
            {
               _loc17_.push(_loc19_);
            }
            _loc28_[BuildingSpecificInfoType.SHOTS_PER_SECOND_PER_LEVEL.id] = _loc17_;
         }
         if("staff_prerequisites_per_level" in param1)
         {
            _loc103_ = new Vector.<Vector.<StaffDIO>>();
            _loc30_ = 0;
            while(_loc30_ < param1["staff_prerequisites_per_level"].length)
            {
               _loc103_[_loc30_] = new Vector.<StaffDIO>();
               _loc61_ = 0;
               while(_loc61_ < param1["staff_prerequisites_per_level"][_loc30_].length)
               {
                  _loc103_[_loc30_].push(getStaff(param1["staff_prerequisites_per_level"][_loc30_][_loc61_]));
                  _loc61_++;
               }
               _loc30_++;
            }
            _loc28_[BuildingSpecificInfoType.STAFF_PREREQUISITES_PER_LEVEL.id] = _loc103_;
         }
         if("gold_cost_per_staff" in param1)
         {
            _loc28_[BuildingSpecificInfoType.GOLD_COST_PER_STAFF.id] = param1["gold_cost_per_staff"];
            _loc28_[BuildingSpecificInfoType.GOLD_COST_DISCOUNT_PERCENTAGE.id] = 20;
         }
         if("staff_time_reductions_per_level" in param1)
         {
            _loc83_ = new Vector.<Vector.<int>>();
            _loc4_ = param1["staff_time_reductions_per_level"];
            _loc30_ = 0;
            while(_loc30_ < _loc4_.length)
            {
               _loc16_ = _loc4_[_loc30_];
               _loc91_ = new Vector.<int>();
               _loc61_ = 0;
               while(_loc61_ < _loc16_.length)
               {
                  _loc91_.push(_loc16_[_loc61_]);
                  _loc61_++;
               }
               _loc83_.push(_loc91_);
               _loc30_++;
            }
            _loc28_[BuildingSpecificInfoType.STAFF_TIME_REDUCTION_PER_LEVEL.id] = _loc83_;
         }
         if("gold_cost_discount_percentage" in param1)
         {
            _loc28_[BuildingSpecificInfoType.GOLD_COST_DISCOUNT_PERCENTAGE.id] = param1["gold_cost_discount_percentage"];
         }
         if("queue_slot" in param1)
         {
            _loc89_ = new Vector.<int>();
            _loc30_ = 0;
            while(_loc30_ < param1["queue_slot"].length)
            {
               _loc89_.push(param1["queue_slot"][_loc30_]);
               _loc30_++;
            }
            _loc28_[BuildingSpecificInfoType.HIRING_QUEUE_SLOT_PER_LEVEL.id] = _loc89_;
         }
         if("gold_production_amount" in param1)
         {
            _loc28_[BuildingSpecificInfoType.GOLD_PRODUCTION_AMOUNT.id] = param1["gold_production_amount"];
         }
         if("gold_production_periods_in_hours" in param1)
         {
            _loc26_ = new Vector.<Number>();
            _loc30_ = 0;
            while(_loc30_ < param1["gold_production_periods_in_hours"].length)
            {
               _loc26_.push(param1["gold_production_periods_in_hours"][_loc30_]);
               _loc30_++;
            }
            _loc28_[BuildingSpecificInfoType.GOLD_PRODUCTION_PERIODS_IN_HOURS_PER_LEVEL.id] = _loc26_;
         }
         if("gold_capacity" in param1)
         {
            _loc28_[BuildingSpecificInfoType.GOLD_CAPACITY.id] = param1["gold_capacity"];
         }
         if("small_resource_gift_amounts_per_level" in param1)
         {
            _loc46_ = new Vector.<int>();
            _loc11_ = param1["small_resource_gift_amounts_per_level"];
            _loc30_ = 0;
            while(_loc30_ < _loc11_.length)
            {
               _loc46_.push(_loc11_[_loc30_]);
               _loc30_++;
            }
            _loc28_[BuildingSpecificInfoType.SMALL_GIFT_AMOUNTS.id] = _loc46_;
         }
         if("large_resource_gift_amounts_per_level" in param1)
         {
            _loc45_ = new Vector.<int>();
            _loc11_ = param1["large_resource_gift_amounts_per_level"];
            _loc30_ = 0;
            while(_loc30_ < _loc11_.length)
            {
               _loc45_.push(_loc11_[_loc30_]);
               _loc30_++;
            }
            _loc28_[BuildingSpecificInfoType.LARGE_GIFT_AMOUNTS.id] = _loc45_;
         }
         if("huge_resource_gift_amounts_per_level" in param1)
         {
            _loc65_ = new Vector.<int>();
            _loc11_ = param1["huge_resource_gift_amounts_per_level"];
            _loc30_ = 0;
            while(_loc30_ < _loc11_.length)
            {
               _loc65_.push(_loc11_[_loc30_]);
               _loc30_++;
            }
            _loc28_[BuildingSpecificInfoType.HUGE_GIFT_AMOUNTS.id] = _loc65_;
         }
         if("max_ammunition" in param1)
         {
            _loc28_[BuildingSpecificInfoType.BEAST_CANNON_MAX_AMMUNITION.id] = param1["max_ammunition"];
         }
         if("recharge_time_per_ammunition_in_seconds" in param1)
         {
            _loc28_[BuildingSpecificInfoType.BEAST_CANNON_RECHARGE_PER_AMMUNITION.id] = param1["recharge_time_per_ammunition_in_seconds"];
         }
         return new BuildingTypeDIO(_loc92_,_loc38_,param1["base_size"],param1["max_levels"],_loc106_,_loc87_,_loc32_,_loc66_,param1["max_instances"],_loc75_,_loc95_,_loc25_,_loc28_,_loc104_,_loc13_,_loc85_,_loc86_,_loc18_,_loc53_,_loc57_,_loc55_,_loc7_,_loc70_,_loc99_,_loc73_,_loc3_,_loc27_,_loc22_,_loc62_,_loc105_,_loc109_,_loc9_,_loc80_);
      }
      
      private function populateFortificationInfoDIO(param1:Object) : FortificationInfoDIO
      {
         var _loc10_:int = 0;
         var _loc8_:Number = NaN;
         var _loc5_:* = undefined;
         var _loc9_:* = undefined;
         var _loc12_:Vector.<Vector.<ResourceAmountDTO>> = new Vector.<Vector.<ResourceAmountDTO>>();
         var _loc4_:Vector.<Number> = new Vector.<Number>();
         var _loc13_:Vector.<Vector.<PrerequisiteDIO>> = new Vector.<Vector.<PrerequisiteDIO>>();
         var _loc2_:Vector.<int> = new Vector.<int>();
         for each(var _loc6_ in param1["resource_costs"])
         {
            _loc10_ = 0;
            for each(_loc8_ in _loc6_["amounts_per_level"])
            {
               if(_loc10_ == _loc12_.length)
               {
                  _loc5_ = new Vector.<ResourceAmountDTO>();
                  _loc12_.push(_loc5_);
               }
               else
               {
                  _loc5_ = _loc12_[_loc10_];
               }
               _loc10_++;
               _loc5_.push(new ResourceAmountDTO(_loc6_["resource"],_loc8_));
            }
         }
         for each(var _loc3_ in param1["fortify_durations_per_level_in_secs"])
         {
            _loc4_.push(_loc3_);
         }
         for each(var _loc7_ in param1["building_prerequisites_per_level"])
         {
            _loc9_ = new Vector.<PrerequisiteDIO>();
            for each(var _loc11_ in _loc7_)
            {
               _loc9_.push(new PrerequisiteDIO(_loc11_["building"],_loc11_["level"]));
            }
            _loc13_.push(_loc9_);
         }
         _loc10_ = 0;
         while(_loc10_ < param1["protection_bonuses_per_level_as_percent"].length)
         {
            _loc2_.push(param1["protection_bonuses_per_level_as_percent"][_loc10_]);
            _loc10_++;
         }
         return new FortificationInfoDIO(param1["max_levels"],_loc12_,_loc4_,_loc13_,_loc2_);
      }
      
      public function getPart(param1:int) : PartTypeDIO
      {
         return param1 in partMap ? partMap[param1] : null;
      }
      
      public function getBuilding(param1:int) : BuildingTypeDIO
      {
         return buildingMap[param1];
      }
      
      public function getBuildings() : Vector.<BuildingTypeDIO>
      {
         return buildingVector;
      }
      
      public function getBuildingsByBuildMenuCategory(param1:BuildMenuCategory) : Vector.<BuildingTypeDIO>
      {
         var _loc3_:Vector.<BuildingTypeDIO> = new Vector.<BuildingTypeDIO>();
         for each(var _loc2_ in buildingMap)
         {
            if(_loc2_.buildMenuCategory == param1 && _loc2_.id != 22)
            {
               _loc3_.push(_loc2_);
            }
         }
         _loc3_.sort(compareBuildingsOnBuildMenuIndex);
         return _loc3_;
      }
      
      public function getDecoration(param1:int) : DecorationTypeDIO
      {
         return decorationMap[param1];
      }
      
      public function getDecorations() : Vector.<DecorationTypeDIO>
      {
         return decorationVector;
      }
      
      public function getDecorationsByBuildMenuCategory(param1:BuildMenuDecorationCategory) : Vector.<DecorationTypeDIO>
      {
         var _loc3_:Vector.<DecorationTypeDIO> = new Vector.<DecorationTypeDIO>();
         for each(var _loc2_ in decorationMap)
         {
            if(_loc2_.buildMenuDecorationCategory == param1)
            {
               _loc3_.push(_loc2_);
            }
         }
         return _loc3_;
      }
      
      public function getUnits(param1:UnitAccessType = null, param2:Boolean = false) : Vector.<UnitTypeDIO>
      {
         var _loc4_:Boolean = false;
         if(param1 == null)
         {
            param1 = UnitAccessType.DEFAULT;
         }
         if(param1 == UnitAccessType.ALL)
         {
            if(param2)
            {
               return unitVector.concat(deprecatedUnitVector);
            }
            return unitVector;
         }
         var _loc5_:Vector.<UnitTypeDIO> = new Vector.<UnitTypeDIO>();
         _loc4_ = param1 == UnitAccessType.EVENT;
         for each(var _loc3_ in unitVector)
         {
            if(_loc3_.event == _loc4_)
            {
               _loc5_.push(_loc3_);
            }
         }
         return _loc5_;
      }
      
      public function getUnit(param1:int) : UnitTypeDIO
      {
         return unitMap[param1];
      }
      
      public function getWorker() : WorkerTypeDIO
      {
         return _worker;
      }
      
      public function getConstants() : ConstantsDIO
      {
         return _constants;
      }
      
      public function getConstructableKind(param1:int) : ConstructableKindTypeDIO
      {
         return constructableKindMap[param1];
      }
      
      public function getBuildingKinds() : Vector.<ConstructableKindTypeDIO>
      {
         return buildingKindVector;
      }
      
      public function getEventItem(param1:int) : EventItemDIO
      {
         return _eventItemMap[param1];
      }
      
      public function getEventItems() : Vector.<EventItemDIO>
      {
         return eventItemVector;
      }
      
      private function populateBeast(param1:Object, param2:Object) : BeastTypeDIO
      {
         var _loc22_:int = 0;
         var _loc15_:int = 0;
         var _loc40_:int = 0;
         var _loc47_:Object = null;
         var _loc13_:* = undefined;
         var _loc29_:PrerequisiteDIO = null;
         var _loc43_:Boolean = false;
         var _loc34_:Boolean = false;
         var _loc39_:Boolean = false;
         var _loc46_:String = null;
         var _loc21_:int = 0;
         var _loc33_:int = 0;
         var _loc41_:int = int(param1["id"]);
         var _loc30_:Vector.<int> = new Vector.<int>();
         var _loc32_:Vector.<int> = new Vector.<int>();
         var _loc48_:Vector.<int> = new Vector.<int>();
         var _loc6_:Vector.<Number> = new Vector.<Number>();
         var _loc45_:Vector.<Number> = new Vector.<Number>();
         var _loc36_:Vector.<int> = new Vector.<int>();
         var _loc23_:Vector.<int> = new Vector.<int>();
         var _loc49_:Vector.<int> = new Vector.<int>();
         var _loc35_:Vector.<int> = new Vector.<int>();
         var _loc26_:Vector.<int> = new Vector.<int>();
         var _loc4_:Vector.<int> = new Vector.<int>();
         var _loc20_:Vector.<Vector.<UnitTypeAmountDTO>> = new Vector.<Vector.<UnitTypeAmountDTO>>();
         var _loc53_:Vector.<int> = new Vector.<int>();
         var _loc5_:Vector.<int> = new Vector.<int>();
         var _loc11_:Vector.<int> = new Vector.<int>();
         var _loc3_:int = int(param1["pre_training_duration_in_secs"]);
         var _loc37_:int = int(param1["wait_training_duration_in_secs"]);
         var _loc7_:int = int(param1["max_bonus_stages"]);
         var _loc24_:Vector.<Number> = new Vector.<Number>();
         var _loc25_:Vector.<int> = new Vector.<int>();
         var _loc10_:Vector.<int> = new Vector.<int>();
         var _loc51_:Vector.<int> = new Vector.<int>();
         var _loc18_:Vector.<int> = new Vector.<int>();
         var _loc38_:Number = 0;
         var _loc44_:Vector.<int> = new Vector.<int>();
         var _loc16_:Vector.<Vector.<UnitTypeAmountDTO>> = new Vector.<Vector.<UnitTypeAmountDTO>>();
         var _loc54_:Vector.<int> = new Vector.<int>();
         var _loc12_:Vector.<int> = new Vector.<int>();
         var _loc27_:int = int(param1["max_levels"]);
         var _loc17_:Boolean = false;
         var _loc50_:Dictionary = extractUnitSpecificInfo(param1,param2);
         if("flying" in param1)
         {
            _loc43_ = Boolean(param1["flying"]);
         }
         if("underground" in param1)
         {
            _loc34_ = Boolean(param1["underground"]);
         }
         if("healer" in param1)
         {
            _loc39_ = Boolean(param1["healer"]);
         }
         if("favourite_targets" in param1)
         {
            _loc22_ = 0;
            while(_loc22_ < param1["favourite_targets"].length)
            {
               _loc30_.push(param1["favourite_targets"][_loc22_]);
               _loc22_++;
            }
         }
         if("favourite_targets_for_max_level" in param1)
         {
            _loc22_ = 0;
            while(_loc22_ < param1["favourite_targets_for_max_level"].length)
            {
               _loc32_.push(param1["favourite_targets_for_max_level"][_loc22_]);
               _loc22_++;
            }
         }
         if("prerequisite" in param1)
         {
            _loc29_ = new PrerequisiteDIO(param1["prerequisite"]["building"],param1["prerequisite"]["level"]);
         }
         if("damage_per_seconds_per_level" in param1)
         {
            _loc22_ = 0;
            while(_loc22_ < param1["damage_per_seconds_per_level"].length)
            {
               _loc48_.push(param1["damage_per_seconds_per_level"][_loc22_]);
               _loc22_++;
            }
         }
         if("healing_times_per_level" in param1)
         {
            _loc22_ = 0;
            while(_loc22_ < param1["healing_times_per_level"].length)
            {
               _loc49_.push(param1["healing_times_per_level"][_loc22_]);
               _loc22_++;
            }
         }
         if("healing_cost_times_per_level" in param1)
         {
            _loc22_ = 0;
            while(_loc22_ < param1["healing_cost_times_per_level"].length)
            {
               _loc35_.push(param1["healing_cost_times_per_level"][_loc22_]);
               _loc22_++;
            }
         }
         if("ranges_per_level" in param1)
         {
            _loc22_ = 0;
            while(_loc22_ < param1["ranges_per_level"].length)
            {
               _loc26_.push(param1["ranges_per_level"][_loc22_]);
               _loc22_++;
            }
         }
         if("buffs_per_level" in param1)
         {
            _loc22_ = 0;
            while(_loc22_ < param1["buffs_per_level"].length)
            {
               _loc4_.push(param1["buffs_per_level"][_loc22_]);
               _loc22_++;
            }
         }
         if("speeds_per_level" in param1)
         {
            _loc22_ = 0;
            while(_loc22_ < param1["speeds_per_level"].length)
            {
               _loc6_.push(param1["speeds_per_level"][_loc22_]);
               _loc45_.push(param1["speeds_per_level"][_loc22_] * _constants.yardUnitPerSecond / 60);
               _loc22_++;
            }
         }
         if("health_points_per_level" in param1)
         {
            _loc22_ = 0;
            while(_loc22_ < param1["health_points_per_level"].length)
            {
               _loc36_.push(param1["health_points_per_level"][_loc22_]);
               _loc22_++;
            }
         }
         if("damage_points_per_level" in param1)
         {
            _loc22_ = 0;
            while(_loc22_ < param1["damage_points_per_level"].length)
            {
               _loc23_.push(param1["damage_points_per_level"][_loc22_]);
               _loc22_++;
            }
         }
         if("training_costs_per_level" in param1)
         {
            _loc15_ = 0;
            while(_loc15_ < param1["training_costs_per_level"].length)
            {
               _loc47_ = param1["training_costs_per_level"][_loc15_];
               _loc13_ = new Vector.<UnitTypeAmountDTO>();
               _loc22_ = 0;
               while(_loc22_ < _loc47_["unitNames"].length)
               {
                  _loc13_.push(new UnitTypeAmountDTO(_loc47_["unitNames"][_loc22_],_loc47_["amounts"][_loc22_]));
                  _loc22_++;
               }
               _loc20_.push(_loc13_);
               _loc15_++;
            }
         }
         else
         {
            _loc22_ = 0;
            while(_loc22_ < _loc27_)
            {
               _loc20_.push(new Vector.<UnitTypeAmountDTO>());
               _loc22_++;
            }
         }
         if("training_gold_costs_per_level" in param1)
         {
            _loc22_ = 0;
            while(_loc22_ < param1["training_gold_costs_per_level"].length)
            {
               _loc53_.push(param1["training_gold_costs_per_level"][_loc22_]);
               _loc22_++;
            }
         }
         if("level_up_gold_costs_per_level" in param1)
         {
            _loc22_ = 0;
            while(_loc22_ < param1["level_up_gold_costs_per_level"].length)
            {
               _loc5_.push(param1["level_up_gold_costs_per_level"][_loc22_]);
               _loc22_++;
            }
         }
         if("number_of_trainings_to_level_up_per_level" in param1)
         {
            _loc22_ = 0;
            while(_loc22_ < param1["number_of_trainings_to_level_up_per_level"].length)
            {
               _loc11_.push(param1["number_of_trainings_to_level_up_per_level"][_loc22_]);
               _loc22_++;
            }
         }
         if("speeds_per_stage" in param1)
         {
            _loc22_ = 0;
            while(_loc22_ < param1["speeds_per_stage"].length)
            {
               _loc24_.push(param1["speeds_per_stage"][_loc22_]);
               _loc22_++;
            }
         }
         if("health_points_per_stage" in param1)
         {
            _loc22_ = 0;
            while(_loc22_ < param1["health_points_per_stage"].length)
            {
               _loc25_.push(param1["health_points_per_stage"][_loc22_]);
               _loc22_++;
            }
         }
         if("damage_points_per_stage" in param1)
         {
            _loc22_ = 0;
            while(_loc22_ < param1["damage_points_per_stage"].length)
            {
               _loc10_.push(param1["damage_points_per_stage"][_loc22_]);
               _loc22_++;
            }
         }
         if("damage_per_seconds_per_stage" in param1)
         {
            _loc22_ = 0;
            while(_loc22_ < param1["damage_per_seconds_per_stage"].length)
            {
               _loc51_.push(param1["damage_per_seconds_per_stage"][_loc22_]);
               _loc22_++;
            }
         }
         if("ranges_per_stage" in param1)
         {
            _loc22_ = 0;
            while(_loc22_ < param1["ranges_per_stage"].length)
            {
               _loc18_.push(param1["ranges_per_stage"][_loc22_]);
               _loc22_++;
            }
         }
         if("splash_range" in param1)
         {
            _loc38_ = Number(param1["splash_range"]);
         }
         if("buffs_per_stage" in param1)
         {
            _loc22_ = 0;
            while(_loc22_ < param1["buffs_per_stage"].length)
            {
               _loc44_.push(param1["buffs_per_stage"][_loc22_]);
               _loc22_++;
            }
         }
         if("training_costs_per_stage" in param1)
         {
            _loc40_ = 0;
            while(_loc40_ < param1["training_costs_per_stage"].length)
            {
               _loc47_ = param1["training_costs_per_stage"][_loc40_];
               _loc13_ = new Vector.<UnitTypeAmountDTO>();
               _loc22_ = 0;
               while(_loc22_ < _loc47_["unitNames"].length)
               {
                  _loc13_.push(new UnitTypeAmountDTO(_loc47_["unitNames"][_loc22_],_loc47_["amounts"][_loc22_]));
                  _loc22_++;
               }
               _loc16_.push(_loc13_);
               _loc40_++;
            }
         }
         else
         {
            _loc22_ = 0;
            while(_loc22_ < _loc7_)
            {
               _loc16_.push(new Vector.<UnitTypeAmountDTO>());
               _loc22_++;
            }
         }
         if("training_gold_costs_per_stage" in param1)
         {
            _loc22_ = 0;
            while(_loc22_ < param1["training_gold_costs_per_stage"].length)
            {
               _loc54_.push(param1["training_gold_costs_per_stage"][_loc22_]);
               _loc22_++;
            }
         }
         if("level_up_gold_costs_per_stage" in param1)
         {
            _loc22_ = 0;
            while(_loc22_ < param1["level_up_gold_costs_per_stage"].length)
            {
               _loc12_.push(param1["level_up_gold_costs_per_stage"][_loc22_]);
               _loc22_++;
            }
         }
         if("event" in param1)
         {
            _loc17_ = true;
         }
         var _loc28_:Vector.<Point> = new Vector.<Point>();
         var _loc14_:Boolean = false;
         var _loc19_:Number = 1;
         var _loc42_:Point = new Point();
         var _loc31_:String = "";
         var _loc9_:Boolean = false;
         var _loc52_:String = null;
         if("asset_name" in param2)
         {
            _loc46_ = param2["asset_name"];
         }
         if("animation_sort_points_per_stage" in param2)
         {
            for each(var _loc8_ in param2["animation_sort_points_per_stage"])
            {
               _loc28_.push(new Point(_loc8_.x,_loc8_.y));
            }
         }
         if("movement_animation_speed" in param2)
         {
            _loc21_ = int(param2["movement_animation_speed"]);
         }
         if("attack_animation_speed" in param2)
         {
            _loc33_ = int(param2["attack_animation_speed"]);
         }
         if("unlocked" in param2)
         {
            _loc14_ = Boolean(param2["unlocked"]);
         }
         if("select_view" in param2)
         {
            if("scale" in param2["select_view"])
            {
               _loc19_ = Number(param2["select_view"]["scale"]);
            }
            if("offset" in param2["select_view"])
            {
               _loc42_ = new Point(param2["select_view"]["offset"]["x"],param2["select_view"]["offset"]["y"]);
            }
         }
         if("particle_asset" in param2)
         {
            _loc31_ = param2["particle_asset"];
         }
         if("particle_rotate" in param2)
         {
            _loc9_ = Boolean(param2["particle_rotate"]);
         }
         if("particle_sound" in param2)
         {
            _loc52_ = param2["particle_sound"];
         }
         return new BeastTypeDIO(_loc41_,_loc30_,_loc29_,_loc48_,_loc49_,_loc35_,_loc26_,_loc38_,_loc4_,_loc6_,_loc45_,_loc36_,_loc23_,_loc20_,_loc53_,_loc5_,_loc11_,_loc3_,_loc37_,_loc7_,_loc24_,_loc25_,_loc10_,_loc51_,_loc18_,_loc44_,_loc16_,_loc54_,_loc12_,_loc27_,_loc50_,_loc46_,_loc21_,_loc33_,_loc43_,_loc28_,_loc34_,_loc39_,_loc17_,_loc32_,_loc14_,_loc19_,_loc42_,_loc31_,_loc9_,_loc52_);
      }
      
      public function populateAllBeasts() : void
      {
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:Object = null;
         var _loc2_:Object = null;
         var _loc1_:BeastTypeDIO = null;
         _beastMap = new Dictionary();
         beastVector = new Vector.<BeastTypeDIO>();
         _loc5_ = 0;
         while(_loc5_ < domainInfo["beasts"].length)
         {
            _loc3_ = domainInfo["beasts"][_loc5_];
            _loc4_ = 0;
            while(_loc4_ < visualInfo["beasts"].length)
            {
               _loc2_ = visualInfo["beasts"][_loc4_];
               if(_loc3_["id"] == _loc2_["id"])
               {
                  _loc1_ = populateBeast(_loc3_,_loc2_);
                  _beastMap[_loc1_.id] = _loc1_;
                  beastVector.push(_loc1_);
                  break;
               }
               _loc4_++;
            }
            _loc5_++;
         }
         beastVector.sort(onBeastSort);
      }
      
      public function getBeasts() : Vector.<BeastTypeDIO>
      {
         return beastVector;
      }
      
      public function getBeast(param1:int) : BeastTypeDIO
      {
         return param1 in _beastMap ? _beastMap[param1] : null;
      }
      
      public function getBeastMap() : Dictionary
      {
         return _beastMap;
      }
      
      public function getUnitMap() : Dictionary
      {
         return unitMap;
      }
      
      public function populateAllStaffs() : void
      {
         var _loc3_:int = 0;
         var _loc2_:Object = null;
         var _loc1_:StaffDIO = null;
         _staffMap = new Dictionary();
         staffVector = new Vector.<StaffDIO>();
         _loc3_ = 0;
         while(_loc3_ < domainInfo["staffs"].length)
         {
            _loc2_ = domainInfo["staffs"][_loc3_];
            _loc1_ = new StaffDIO(_loc2_["id"]);
            _staffMap[_loc1_.id] = _loc1_;
            staffVector.push(_loc1_);
            _loc3_++;
         }
         staffVector.sort(onStaffSort);
      }
      
      public function getStaffs() : Vector.<StaffDIO>
      {
         return staffVector;
      }
      
      public function getStaff(param1:int) : StaffDIO
      {
         return _staffMap[param1];
      }
      
      public function getStaffMap() : Dictionary
      {
         return _staffMap;
      }
      
      public function getItems() : Vector.<PartTypeDIO>
      {
         var _loc1_:Vector.<PartTypeDIO> = new Vector.<PartTypeDIO>();
         for each(var _loc2_ in partMap)
         {
            _loc1_.push(_loc2_);
         }
         return _loc1_;
      }
      
      public function getMapLayout() : Object
      {
         return _mapLayout;
      }
      
      public function getCampaignLayout() : Object
      {
         return _campaignLayout;
      }
      
      public function getTerrainLayout() : Object
      {
         return _terrainLayout;
      }
      
      public function populateAllLeagueLevels() : void
      {
         _leagueLevelMap = new Dictionary();
         _leagueLevelVector = new Vector.<LeagueLevelDIO>();
         _leagueLevelVector.push(new LeagueLevelDIO(0,0,0,0,0,0,0,0,0,0));
         _leagueLevelVector.push(new LeagueLevelDIO(1,1,1,50,99,10,50,150,90,45));
         _leagueLevelVector.push(new LeagueLevelDIO(2,1,2,100,199,50,65,165,90,60));
         _leagueLevelVector.push(new LeagueLevelDIO(3,1,3,200,349,150,80,180,105,60));
         _leagueLevelVector.push(new LeagueLevelDIO(4,2,1,350,549,250,95,195,105,75));
         _leagueLevelVector.push(new LeagueLevelDIO(5,2,2,550,799,450,110,210,120,75));
         _leagueLevelVector.push(new LeagueLevelDIO(6,2,3,800,1099,650,125,225,120,90));
         _leagueLevelVector.push(new LeagueLevelDIO(7,3,1,1100,1399,950,140,240,135,90));
         _leagueLevelVector.push(new LeagueLevelDIO(8,3,2,1400,1699,1250,155,255,135,105));
         _leagueLevelVector.push(new LeagueLevelDIO(9,3,3,1700,1999,1550,170,270,150,105));
         _leagueLevelVector.push(new LeagueLevelDIO(10,4,1,2000,2199,1900,185,285,150,120));
         _leagueLevelVector.push(new LeagueLevelDIO(11,4,2,2200,2399,2100,200,300,165,120));
         _leagueLevelVector.push(new LeagueLevelDIO(12,4,3,2400,2599,2300,215,315,165,135));
         _leagueLevelVector.push(new LeagueLevelDIO(13,5,1,2600,2799,2500,230,330,180,135));
         _leagueLevelVector.push(new LeagueLevelDIO(14,5,2,2800,2999,2700,245,345,180,150));
         _leagueLevelVector.push(new LeagueLevelDIO(15,5,3,3000,3199,2900,275,345,195,150));
         _leagueLevelVector.push(new LeagueLevelDIO(16,6,1,3200,1.7976931348623157e+308,3100,300,360,195,165));
         for each(var _loc1_ in _leagueLevelVector)
         {
            _leagueLevelMap[_loc1_.id] = _loc1_;
         }
      }
      
      public function getLeagueLevels() : Vector.<LeagueLevelDIO>
      {
         return _leagueLevelVector;
      }
      
      public function getLeagueLevel(param1:Number) : LeagueLevelDIO
      {
         return param1 in _leagueLevelMap ? _leagueLevelMap[param1] : null;
      }
      
      private function populateAllTavernItems() : void
      {
         var _loc2_:int = 0;
         var _loc1_:Object = null;
         var _loc3_:TavernItemDIO = null;
         _tavernItemMap = new Dictionary();
         _tavernItemVector = new Vector.<TavernItemDIO>();
         _tavernItemUnlockMap = new Dictionary();
         _loc2_ = 0;
         while(_loc2_ < visualInfo["tavern_items"].length)
         {
            _loc1_ = visualInfo["tavern_items"][_loc2_];
            _loc3_ = populateTavernItem(_loc1_);
            _tavernItemMap[_loc3_.id] = _loc3_;
            _tavernItemVector.push(_loc3_);
            if(_loc3_.unlockCardIndex >= 0)
            {
               _tavernItemUnlockMap[_loc3_.unlockCardIndex] = _loc3_;
            }
            _loc2_++;
         }
         _tavernItemVector.sort(onTavernItemSort);
      }
      
      public function getTavernItems() : Vector.<TavernItemDIO>
      {
         return _tavernItemVector;
      }
      
      public function getTavernItem(param1:int) : TavernItemDIO
      {
         return param1 in _tavernItemMap ? _tavernItemMap[param1] : null;
      }
      
      public function getUnlockedTavernItem(param1:int) : TavernItemDIO
      {
         return param1 in _tavernItemUnlockMap ? _tavernItemUnlockMap[param1] : null;
      }
      
      public function getCatapults() : Dictionary
      {
         return _catapultMap;
      }
      
      public function getCatapult(param1:int) : CatapultTypeDIO
      {
         return _catapultMap[param1];
      }
   }
}

