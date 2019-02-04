package
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;

	[SWF(frameRate = "60", backgroundColor = "0xEEEEEE")]
	public class particle_step2 extends Sprite
	{
		private const size:int = 10;
		private var particleList:Array = [];

		/** コンストラクター */
		public function particle_step2()
		{
			// for文を作成 (上限数はパーティクルの個数)
			for (var i:int = 0; i < 20; i++)
			{
				// 赤い丸を作成
				var particle:MovieClip = new MovieClip();
				particle.graphics.beginFill(0xFF0000);
				particle.graphics.drawCircle(0, 0, size);
				this.addChild(particle);
			
				particle.x = stage.stageWidth * Math.random();
				particle.y = stage.stageHeight * Math.random();
				particle.vx = 0;
				particle.vy = 0;
				// 配列に保存
				particleList[i] = particle;
			}

			// 時間経過
			this.addEventListener(Event.ENTER_FRAME, handleTick);
		}

		private function handleTick(event):void
		{
			for (var i:int = 0; i < particleList.length; i++)
			{
				// i番目の要素を変数に代入
				var particle:MovieClip = particleList[i];
				// 重力
				particle.vy += 1;
				// 摩擦
				particle.vx *= 0.95;
				particle.vy *= 0.95;
				// 反映
				particle.x += particle.vx;
				particle.y += particle.vy;
				if (particle.y > stage.stageHeight - size)
				{ // 地面
					particle.y = stage.stageHeight - size; // 行き過ぎ補正
					particle.vy *= -1; // Y軸の速度を反転
				}
			}
		}
	}
}
