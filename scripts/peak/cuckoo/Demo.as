package peak.cuckoo
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import peak.cuckoo.game.GameSprite;
   import peak.cuckoo.game.Root;
   import peak.cuckoo.game.behavior.render.BaseRender;
   
   public class Demo extends Sprite
   {
      
      public static const WIDTH:int = 1200;
      
      public static const HEIGTH:int = 900;
      
      public static const MARGIN:int = 50;
      
      private var gameRoot:Root;
      
      private var ground:GameSprite;
      
      private var soldier:GameSprite;
      
      private var airplane:GameSprite;
      
      private var fps:Sprite;
      
      private var frameCounter:int = -10;
      
      private var inc:Boolean = false;
      
      public function Demo()
      {
         super();
         gameRoot = new Root();
         addEventListener("addedToStage",onAddedToStage);
         gameRoot.init();
         createGameObjects();
         addChild((gameRoot.componentManager["BaseRender"] as BaseRender).canvas);
         addChild(fps = new FpsCounter(stage.stageWidth - 40,5));
      }
      
      private function createGameObjects() : void
      {
         ground = new GameSprite();
         gameRoot.addChild(ground);
         gameRoot.layers[0].renderChildrenContainer.renderChildren.push(ground);
         ground.init();
         ground.position.move(0,0,0);
         soldier = new GameSprite();
         gameRoot.addChild(soldier);
         gameRoot.layers[3].renderChildrenContainer.renderChildren.push(soldier);
         soldier.init();
         soldier.position.move(5,5,0);
         airplane = new GameSprite();
         gameRoot.addChild(airplane);
         gameRoot.layers[4].renderChildrenContainer.renderChildren.push(airplane);
         airplane.init();
         airplane.position.move(4,4,0);
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         stage.align = "TL";
         stage.scaleMode = "noScale";
         addEventListener("enterFrame",enterFrameHandler);
         stage.addEventListener("keyDown",gameRoot.keyPressed,false,0,true);
         onStageResize();
         stage.addEventListener("resize",onStageResize);
      }
      
      private function onStageResize(param1:Event = null) : void
      {
         gameRoot.render.canvasRect = new Rectangle(50,50,stage.stageWidth - 50 * 2,stage.stageHeight - 50 * 2);
         var _loc2_:Viewport = gameRoot.viewport;
         if(_loc2_.rect.x < _loc2_.bounds.x || _loc2_.rect.x + _loc2_.rect.width > _loc2_.bounds.x + _loc2_.bounds.width || _loc2_.rect.y < _loc2_.bounds.y || _loc2_.rect.y + _loc2_.rect.height > _loc2_.bounds.y + _loc2_.bounds.height)
         {
            _loc2_.moveTo(_loc2_.rect.x,_loc2_.rect.y);
         }
         undefined;
         fps.x = stage.stageWidth - 40;
      }
      
      private function enterFrameHandler(param1:Event) : void
      {
         gameRoot.update();
         if(frameCounter == -30)
         {
            inc = true;
         }
         else if(frameCounter == 30)
         {
            inc = false;
         }
         if(inc)
         {
            frameCounter = frameCounter + 1;
         }
         else
         {
            frameCounter = frameCounter - 1;
         }
         soldier.position.move(5 + frameCounter * 0.5,5 + frameCounter * 0.5,0);
         airplane.position.move(frameCounter,(inc ? -1 : 1) * Math.sqrt(900 - frameCounter * frameCounter),0);
      }
   }
}

