package wom.service.kontagent
{
   import flash.errors.IOError;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import flash.net.sendToURL;
   import net.peakgames.ane.kontagent.KontagentController;
   import peak.logging.log;
   import peak.serialization.json.PJSON;
   import wom.ClientLoader;
   import wom.model.configuration.WomDocumentConfiguration;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.attack.GameModeType;
   import wom.model.game.experience.ExperienceUtil;
   import wom.model.game.resource.ResourceType;
   import wom.service.logging.WomLoggerContexts;
   
   public class WomKontagentApi
   {
      
      private static const PEAK_API_URL:String = "http://api.peakgames.net/api/v1/" + ClientLoader.KT_API_KEY;
      
      [Inject]
      public var documentConfiguration:WomDocumentConfiguration;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var city:CityStatusInfo;
      
      public function WomKontagentApi()
      {
         super();
      }
      
      public function trackUIEvent(param1:Object = null, param2:Object = null, param3:Object = null, param4:Object = null, param5:Boolean = true) : void
      {
         var _loc6_:Object = {};
         if(param1 != null)
         {
            _loc6_.st1 = param1.toString();
         }
         if(param2 != null)
         {
            _loc6_.st2 = param2.toString();
         }
         if(param3 != null)
         {
            _loc6_.st3 = param3.toString();
         }
         if(param4 != null)
         {
            _loc6_.value = int(param4);
         }
         trackCustomEvent("UI",_loc6_,param5);
      }
      
      public function trackCustomEvent(param1:String, param2:Object = null, param3:Boolean = true) : void
      {
         var _loc7_:Object = null;
         var _loc4_:String = null;
         var _loc6_:Object = null;
         var _loc5_:Number = documentConfiguration.hasParameter("kid") ? documentConfiguration.getParameter("kid") : 1;
         if(!isNaN(_loc5_))
         {
            if(param3 && city && city.resourceAmounts && userInfo && userInfo.gameMode != GameModeType.ATTACK && userInfo.gameMode != GameModeType.VISIT)
            {
               _loc7_ = {
                  "lumber":city.resourceAmounts[ResourceType.LUMBER.id],
                  "stone":city.resourceAmounts[ResourceType.STONE.id],
                  "might":city.resourceAmounts[ResourceType.MIGHT.id],
                  "iron":city.resourceAmounts[ResourceType.IRON.id],
                  "gold":userInfo.numberOfGolds,
                  "rp":userInfo.reconPoints
               };
               _loc4_ = PJSON.encode(_loc7_);
               if(param2 == null)
               {
                  param2 = {};
               }
               param2.data = _loc4_;
               param2.level = ExperienceUtil.calculateLevelOfExperience(userInfo.experiencePoints);
            }
            try
            {
               if(param2 == null)
               {
                  param2 = {};
               }
               if("subtype1" in param2)
               {
                  param2.st1 = param2.subtype1;
               }
               if("subtype2" in param2)
               {
                  param2.st2 = param2.subtype2;
               }
               if("subtype3" in param2)
               {
                  param2.st3 = param2.subtype3;
               }
               _loc6_ = {
                  "s":_loc5_,
                  "n":param1
               };
               for(var _loc8_ in param2)
               {
                  _loc6_[_loc8_] = param2[_loc8_];
               }
               sendCustomEvent(_loc6_,PEAK_API_URL,param1);
            }
            catch(e:IOError)
            {
            }
            catch(e:SecurityError)
            {
            }
         }
         log(WomLoggerContexts.KONTAGENT,"Event tracked : " + param1);
      }
      
      private function sendCustomEvent(param1:Object, param2:String, param3:String = "evt") : void
      {
         var _loc4_:* = null;
         var _loc5_:* = null;
         KontagentController.getInstance().sendEvent(param3,param1);
      }
      
      public function trackRevenue(param1:Number, param2:int, param3:Object = null, param4:Function = null, param5:Function = null) : void
      {
         var _loc6_:Object = {
            "s":param1,
            "v":param2
         };
         if(param3)
         {
            for(var _loc7_ in param3)
            {
               _loc6_[_loc7_] = param3[_loc7_];
            }
         }
         sendCustomEvent(_loc6_,PEAK_API_URL,"mtu");
      }
   }
}

