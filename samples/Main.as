package{
	import com.MainSprite;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.display.StageAlign;
    import flash.display.StageScaleMode;
	
	import starling.core.Starling;
	
	public class Main extends Sprite
	{
		private var _starling:Starling = null;
		
		public function Main()
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.align = StageAlign.TOP_LEFT;
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function init(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			_starling = new Starling(MainSprite, stage);
			_starling.antiAliasing = 1;
			//_starling.showStats = true;
			_starling.start();
		}
	}
}