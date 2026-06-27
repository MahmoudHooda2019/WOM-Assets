package wom.model.component.behavior.building
{
   import peak.cuckoo.core.Behavior;
   import wom.model.component.WomGameRoot;
   import wom.model.component.attribute.viewManager.BuildingViewManager;
   import wom.model.component.entity.gamesprite.Building;
   import wom.model.game.job.UnitRecruitJob;
   
   public class UnitRecruit extends Behavior
   {
      
      public static const TYPE_ID:String = "UnitRecruit";
      
      public var unitRecruitJob:UnitRecruitJob;
      
      private var under5min:Boolean = false;
      
      private var buildingViewManager:BuildingViewManager;
      
      private var womRoot:WomGameRoot;
      
      public function UnitRecruit(param1:*)
      {
         super();
         this.unitRecruitJob = param1;
      }
      
      override public function get typeId() : String
      {
         return "UnitRecruit";
      }
      
      override public function init() : void
      {
         super.init();
         womRoot = owner.root as WomGameRoot;
         buildingViewManager = (owner as Building).viewManager;
         buildingViewManager.manageRecruitProgressBar();
      }
      
      override public function update() : void
      {
         super.update();
         if(UnitRecruitJob)
         {
            buildingViewManager.manageRecruitProgressBar();
         }
         else
         {
            this.destroy();
         }
      }
      
      override public function destroy() : void
      {
         unitRecruitJob = null;
         buildingViewManager.manageRecruitProgressBar();
         owner.componentManager.remove(this);
         super.destroy();
      }
   }
}

