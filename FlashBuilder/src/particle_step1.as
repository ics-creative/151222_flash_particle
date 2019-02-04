package
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;

	[SWF(frameRate="60", backgroundColor = "0xEEEEEE")]
	public class particle_step1 extends Sprite
	{
		private const size:int = 10;
		private var particle:MovieClip;
		private var vx:Number;
		private var vy:Number;
		
		/** コンストラクター */
		public function particle_step1()
		{
			// 赤い丸を作成
			particle = new MovieClip();
			particle.graphics.beginFill(0xFF0000);
			particle.graphics.drawCircle(0, 0, size);
			particle.x = stage.stageWidth / 2;
		
			// 速度情報
			vx = 0;
			vy = 0;
		
			this.addChild(particle);
		
			// 時間経過
			this.addEventListener(Event.ENTER_FRAME, handleTick);
		}
		
		private function handleTick(event):void
		{
			// 重力
			vy += 1;
			// 摩擦
			vx *= 0.95;
			vy *= 0.95;
			// 反映
			particle.x += vx;
			particle.y += vy;
			// 地面の作成
			if (particle.y > stage.stageHeight - size) {
				particle.y = stage.stageHeight - size; // 行き過ぎ補正
				vy *= -1; // Y軸の速度を反転
			}
		}
	}
}
