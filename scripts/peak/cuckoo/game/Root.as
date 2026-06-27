package peak.cuckoo.game
{
   import flash.events.KeyboardEvent;
   import flash.geom.Rectangle;
   import peak.cuckoo.core.BehaviorUpdater;
   import peak.cuckoo.core.Entity;
   import peak.cuckoo.game.attribute.Viewport;
   import peak.cuckoo.game.attribute.projection.BaseProjection;
   import peak.cuckoo.game.attribute.projection.IsoProjection;
   import peak.cuckoo.game.behavior.AutoScreenPanning;
   import peak.cuckoo.game.behavior.BaseInteract;
   import peak.cuckoo.game.behavior.FpsSync;
   import peak.cuckoo.game.behavior.FpsSyncValidator;
   import peak.cuckoo.game.behavior.MouseInteract;
   import peak.cuckoo.game.behavior.TimeOut;
   import peak.cuckoo.game.behavior.Validator;
   import peak.cuckoo.game.behavior.cull.ViewingFrustumCull;
   import peak.cuckoo.game.behavior.render.BaseRender;
   import peak.cuckoo.game.behavior.sort.ZSort;
   import peak.cuckoo.game.behavior.task.TaskRunner;
   import peak.resource.atlas.AtlasManager;
   import peak.resource.atlas.starling.StarlingAtlasManager;
   import peak.task.TaskQueue;
   import wom.Environment;
   
   public class Root extends Entity
   {
      
      public static const LOGICAL_FPS:int = 60;
      
      public static var PROJECTION_PITCH_X:Number = 12;
      
      public static var PROJECTION_PITCH_Y:Number = 6;
      
      public var behaviorUpdater:BehaviorUpdater;
      
      public var layers:Array;
      
      public var viewport:Viewport;
      
      public var render:BaseRender;
      
      public var scale:Number;
      
      public var screenPanning:AutoScreenPanning;
      
      public var sync:FpsSync;
      
      public var timeOut:TimeOut;
      
      public var isInitialized:Boolean;
      
      public var projection:BaseProjection;
      
      public var userInteract:BaseInteract;
      
      public var taskManager:TaskRunner;
      
      public var validator:Validator;
      
      public var taskQueue:TaskQueue;
      
      protected var errorFlag:Boolean = false;
      
      public var timeFactor:Number = 1;
      
      private var componentProvider:ComponentProvider;
      
      public var atlasManager:StarlingAtlasManager;
      
      public var active:Boolean;
      
      public function Root()
      {
         super();
         sync = new FpsSync(60,this);
         scale = 1;
         this.isInitialized = false;
         behaviorUpdater = new BehaviorUpdater(this);
         this.root = this;
         this.componentProvider = new ComponentProvider(this);
         componentManager.add(validator = new Validator());
         atlasManager = AtlasManager.INSTANCE as StarlingAtlasManager;
      }
      
      protected function standardRoot() : void
      {
         componentManager.add(viewport = new Viewport(new Rectangle(0,0,1200 - 2 * 50,900 - 2 * 50)));
         componentManager.add(projection = new IsoProjection());
         componentManager.add(render = BaseRender.getRender(2));
         componentManager.add(userInteract = new MouseInteract());
         componentManager.add(taskManager = new TaskRunner());
         componentManager.add(screenPanning = new AutoScreenPanning());
         createLayers();
      }
      
      public function update() : void
      {
         behaviorUpdater.updateAll();
      }
      
      protected function createLayers() : void
      {
         layers = [];
         var _loc1_:Layer = new Layer(0);
         _loc1_.componentManager.add(_loc1_.projection = new BaseProjection());
         _loc1_.componentManager.add(_loc1_.cull = new ViewingFrustumCull());
         layers[0] = _loc1_;
         _loc1_ = new Layer(1);
         _loc1_.componentManager.add(_loc1_.projection = new BaseProjection());
         _loc1_.componentManager.add(_loc1_.cull = new ViewingFrustumCull());
         layers[1] = _loc1_;
         _loc1_ = new Layer(2);
         _loc1_.componentManager.add(_loc1_.projection = new BaseProjection());
         _loc1_.componentManager.add(_loc1_.cull = new ViewingFrustumCull());
         layers[2] = _loc1_;
         _loc1_ = new Layer(3);
         _loc1_.componentManager.add(_loc1_.cull = new ViewingFrustumCull());
         _loc1_.componentManager.add(_loc1_.projection = new IsoProjection());
         _loc1_.componentManager.add(_loc1_.sort = new ZSort());
         layers[3] = _loc1_;
         _loc1_ = new Layer(4);
         _loc1_.componentManager.add(_loc1_.projection = new IsoProjection());
         _loc1_.componentManager.add(_loc1_.cull = new ViewingFrustumCull());
         _loc1_.componentManager.add(_loc1_.sort = new ZSort());
         layers[4] = _loc1_;
         for each(var _loc2_ in layers)
         {
            addChild(_loc2_);
         }
      }
      
      override public function init() : void
      {
         sync.init();
         Environment.stage.addEventListener("keyUp",keyReleased,false,0,true);
         taskQueue = new TaskQueue();
         super.init();
         for each(var _loc1_ in layers)
         {
            _loc1_ && _loc1_.init();
         }
         isInitialized = true;
         active = true;
      }
      
      public function keyPressed(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 107)
         {
            render.zoomIn();
         }
         else if(param1.keyCode == 109)
         {
            render.zoomOut();
         }
      }
      
      public function keyReleased(param1:KeyboardEvent) : void
      {
      }
      
      override public function destroyAll() : void
      {
         var _loc1_:Entity = null;
         var _loc3_:int = 0;
         var _loc2_:Vector.<Entity> = new Vector.<Entity>();
         while(children.length > 0)
         {
            _loc1_ = children.pop();
            if(_loc1_ is Layer)
            {
               _loc2_.push(_loc1_);
            }
            else
            {
               _loc1_.destroyAll();
               destroyChild(_loc1_);
            }
         }
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            children.push(_loc2_[_loc3_]);
            _loc3_++;
         }
      }
      
      public function reset() : void
      {
         userInteract.terminate();
         if(taskManager)
         {
            taskManager.terminate();
         }
         behaviorUpdater.terminateAll();
         destroyAll();
         for each(var _loc1_ in layers)
         {
            _loc1_.componentManager.disableAll();
         }
      }
      
      public function onError(param1:Error) : void
      {
      }
      
      public function stopUserInteract() : void
      {
         userInteract.disable();
      }
      
      public function continueUserInteract() : void
      {
         userInteract.enable();
      }
   }
}

