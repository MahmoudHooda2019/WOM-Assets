package peak.cuckoo.game.behavior.render.gpu
{
   import peak.cuckoo.game.attribute.view.BaseView;
   import peak.cuckoo.game.behavior.animation.uvAtlas.UVAtlasActionAnimation;
   import peak.cuckoo.game.behavior.animation.uvAtlas.UVAtlasLoopAnimation;
   import peak.cuckoo.game.behavior.animation.uvAtlas.UVAtlasStateDirectionAnimation;
   import starling.core.Starling;
   import wom.Environment;
   
   public class GpuStarlingRender extends GpuRender
   {
      
      protected var starling:Starling;
      
      public function GpuStarlingRender()
      {
         super();
         renderSpecificLoopAnimation = UVAtlasLoopAnimation;
         renderSpecificActionAnimation = UVAtlasActionAnimation;
         renderSpecificDirectionStateAnimation = UVAtlasStateDirectionAnimation;
         starling = Environment.starling;
      }
      
      override protected function renderScene() : void
      {
         if(projection)
         {
            context3D.setProgramConstantsFromVector("vertex",0,projection,4);
         }
         super.renderScene();
         context3D.setVertexBufferAt(0,null);
         context3D.setVertexBufferAt(1,null);
         context3D.setVertexBufferAt(2,null);
         context3D.setTextureAt(0,null);
         starling.nextFrame();
      }
      
      override protected function presentScene() : void
      {
         if(starling.shareContext)
         {
            super.presentScene();
         }
      }
      
      override public function prepareView(param1:BaseView) : void
      {
         if(!param1.gpuImage)
         {
            if(param1.transformable)
            {
               param1.owner.componentManager.add(param1.gpuImage = param1.gpuTransformableImage = new GpuTransformableImage());
            }
            else
            {
               param1.owner.componentManager.add(param1.gpuImage = new GpuImage());
            }
         }
         param1.gpuImage.init();
         param1.gpuImage.assetReady();
      }
      
      override public function updateView(param1:BaseView) : void
      {
      }
   }
}

