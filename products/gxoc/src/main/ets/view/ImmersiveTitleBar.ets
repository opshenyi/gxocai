import { window } from '@kit.ArkUI';

@Component
export struct ImmersiveTitleBar {
  @Prop title: string = '';
  @State statusBarHeight: number = 0;
  private titleBarHeight: number = 56;
  onBack?: () => void = undefined;

  aboutToAppear(): void {
    window.getLastWindow(this.getUIContext().getHostContext()).then((windowClass: window.Window) => {
      let systemAvoidArea = windowClass.getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM);
      this.statusBarHeight = this.getUIContext().px2vp(systemAvoidArea.topRect.height);

      windowClass.on('avoidAreaChange', (data) => {
        if (data.type === window.AvoidAreaType.TYPE_SYSTEM) {
          this.statusBarHeight = this.getUIContext().px2vp(data.area.topRect.height);
        }
      });
    });
  }

  build() {
    Column() {
      // 状态栏占位
      Row()
        .width('100%')
        .height(this.statusBarHeight)

      // 标题栏内容
      Row() {
        if (this.onBack) {
          Text('<')
            .fontSize(20)
            .fontColor('#FFFFFF')
            .fontWeight(FontWeight.Bold)
            .margin({ left: 16 })
            .onClick(() => {
              if (this.onBack) {
                this.onBack();
              }
            })
        }

        Text(this.title)
          .fontSize(18)
          .fontColor('#FFFFFF')
          .fontWeight(FontWeight.Medium)
          .layoutWeight(1)
          .textAlign(this.onBack ? TextAlign.Center : TextAlign.Start)
          .margin({ left: this.onBack ? 0 : 16, right: 16 })

        // 占位，保持标题居中
        if (this.onBack) {
          Row()
            .width(36)
            .margin({ right: 16 })
        }
      }
      .width('100%')
      .height(this.titleBarHeight)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .backgroundColor('#007DFF')
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP])
  }
}
