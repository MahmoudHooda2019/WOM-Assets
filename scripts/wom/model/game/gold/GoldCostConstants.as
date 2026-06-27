package wom.model.game.gold
{
   import org.robotlegs.mvcs.Actor;
   import wom.model.configuration.WomDocumentConfiguration;
   
   public class GoldCostConstants extends Actor
   {
      
      public static const QUICK_ATTACK_COST:int = 15;
      
      public static const NEXT_QUICK_ATTACK_COST:int = 15;
      
      public static const SPY_COST:int = 8;
      
      public static const EXTEND_ATTACK_TIME_COST:int = 10;
      
      public static const CREATE_ALLIANCE_COST:int = 50;
      
      [Inject]
      public var documentConfiguration:WomDocumentConfiguration;
      
      public function GoldCostConstants()
      {
         super();
      }
      
      public function get tavernSpinCost() : int
      {
         var _loc1_:Number = new Date().getTime();
         if(documentConfiguration.promotionStartTime < _loc1_ && _loc1_ < documentConfiguration.promotionEndTime)
         {
            return documentConfiguration.discountedSpinCost;
         }
         return documentConfiguration.spinCost;
      }
   }
}

