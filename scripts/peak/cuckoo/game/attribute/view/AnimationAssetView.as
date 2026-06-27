package peak.cuckoo.game.attribute.view
{
   import peak.cuckoo.game.behavior.animation.Animation;
   
   public class AnimationAssetView extends AssetView
   {
      
      public function AnimationAssetView(param1:String, param2:int, param3:Boolean = false)
      {
         super(param2,param1,param3);
      }
      
      override public function init() : void
      {
         var _loc1_:Animation = null;
         super.init();
         if("Animation" in owner.componentManager)
         {
            _loc1_ = owner.componentManager["Animation"] as Animation;
            if(owner.root.render.RENDER_TYPE >= 3)
            {
               _loc1_.prepareFrames(null,this);
               prepared = true;
            }
         }
      }
   }
}

