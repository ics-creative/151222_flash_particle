package
{
	import flash.display.BlendMode;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageQuality;
	import flash.events.Event;
	
	import frocessing.color.ColorHSV;

	[SWF(frameRate = "60", backgroundColor = "0x0")]
	public class particle_step4 extends Sprite
	{
		private const size:int = 20;
		private const MAX_LIFE:int = 40; // 寿命の最大値
		private var particle:MovieClip;
		private var particleList:Array = [];
		private var count:int = 0; // tick イベントの回数
		private var hsl:ColorHSV;

		public function particle_step4()
		{
			// 画質を下げて高速化
			stage.quality = StageQuality.MEDIUM;

			// HSLカラーを作成 (Frocessingを利用)
			hsl = new ColorHSV(0, 0.7, 0); // 彩度は70%で指定

			// 時間経過
			this.addEventListener(Event.ENTER_FRAME, handleTick);
		}

		private function handleTick(event):void
		{
			// パーティクルを発生
			emitParticles();
			// パーティクルを更新
			updateParticles();
		}

		/** パーティクルを発生させます */
		private function emitParticles():void
		{
			// for文を作成 (上限数はパーティクルの個数)
			for (var i:int = 0; i < 2; i++)
			{
				hsl.h += 1.5; // 色相は時間経過で変化
				hsl.v = 0.4 + 0.2 * Math.random(); // 明度は40%〜60%でランダム
				var color:uint = hsl.value;
				// 赤い丸を作成
				var particle:MovieClip = new MovieClip();
				particle.graphics.beginFill(color);
				particle.graphics.drawCircle(0, 0, size);
				particle.blendMode = BlendMode.ADD;
				this.addChild(particle);

				// パーティクルの発生場所
				particle.x = stage.mouseX;
				particle.y = stage.mouseY;

				// 動的にプロパティーを追加します。
				// 速度
				particle.vx = 20 * (Math.random() - 0.5);
				particle.vy = 20 * (Math.random() - 0.5);
				// 寿命
				particle.life = MAX_LIFE;

				// 配列に保存
				particleList.push(particle);
			}
		}

		/** パーティクルを更新します */
		private function updateParticles():void
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
				if (particle.y > stage.stageHeight - particle.height / 2)
				{ // 地面
					particle.y = stage.stageHeight - particle.height / 2; // 行き過ぎ補正
					particle.vy *= -1; // Y軸の速度を反転
				}

				// パーティクルのサイズをライフ依存にする
				var scale:Number = particle.life / MAX_LIFE;
				particle.scaleX = particle.scaleY = scale;

				// 寿命を減らす
				particle.life -= 1;
				// 寿命の判定
				if (particle.life <= 0)
				{
					// ステージから削除
					this.removeChild(particle);
					// 配列からも削除
					particleList.splice(i, 1);
				}
			}
		}
	}
}
