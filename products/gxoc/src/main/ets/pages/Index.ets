import { catalogueListComponent } from '../view/CatalogueListComponent';
import CatalogueViewModel from '../viewmodel/CatalogueViewModel';
import { HdsTabs, HdsTabsController, hdsMaterial } from '@kit.UIDesignKit';

@Entry
@Component
struct Index {
  private controller: HdsTabsController = new HdsTabsController();
  @State currentTab: number = 0;

  @Builder
  miniBarBuilder() {
    Row() {
      Stack() {
        Text('+')
          .fontSize(18)
          .fontColor('#FFFFFF')
          .fontWeight(FontWeight.Bold)
      }
      .width(36)
      .height(36)
      .borderRadius(18)
      .backgroundColor('#007DFF')
      .alignContent(Alignment.Center)

      Column({ space: 2 }) {
        Text('快速操作')
          .fontSize(12)
          .fontColor('#182431')
          .fontWeight(FontWeight.Medium)
        Text('点击展开菜单')
          .fontSize(10)
          .fontColor('#8D9299')
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
      }
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
      .margin({ left: 8 })
    }
    .height(48)
    .width('100%')
    .alignItems(VerticalAlign.Center)
    .padding({ left: 10, right: 10 })
  }

  @Builder
  TabContentBuilder(title: string) {
    Column() {
      catalogueListComponent(this.getUIContext(), CatalogueViewModel.getCatalogueData());
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('sys.color.ohos_id_color_sub_background'))
  }

  build() {
    Column() {
      HdsTabs({ controller: this.controller }) {
        TabContent() {
          this.TabContentBuilder('首页')
        }
        .tabBar(new BottomTabBarStyle($r('sys.media.ohos_ic_public_clock'), '首页'))

        TabContent() {
          Column() {
            Text('发现')
              .fontSize(26)
              .fontWeight(FontWeight.Bold)
          }
          .width('100%')
          .height('100%')
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
          .backgroundColor(Color.White)
        }
        .tabBar(new BottomTabBarStyle($r('sys.media.ohos_ic_public_clock'), '发现'))

        TabContent() {
          Column() {
            Text('消息')
              .fontSize(26)
              .fontWeight(FontWeight.Bold)
          }
          .width('100%')
          .height('100%')
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
          .backgroundColor(Color.White)
        }
        .tabBar(new BottomTabBarStyle($r('sys.media.ohos_ic_public_clock'), '消息'))

        TabContent() {
          Column() {
            Text('我的')
              .fontSize(26)
              .fontWeight(FontWeight.Bold)
          }
          .width('100%')
          .height('100%')
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
          .backgroundColor(Color.White)
        }
        .tabBar(new BottomTabBarStyle($r('sys.media.ohos_ic_public_clock'), '我的'))
      }
      .width('100%')
      .height('100%')
      .barOverlap(true)
      .barPosition(BarPosition.End)
      .vertical(false)
      .barFloatingStyle({
        barWidth: { smallWidth: 200, mediumWidth: 240, largeWidth: 280 },
        barBottomMargin: 28,
        gradientMask: { maskColor: '#66F1F3F5', maskHeight: 92 },
        systemMaterialEffect: {
          materialType: hdsMaterial.MaterialType.IMMERSIVE,
          materialLevel: hdsMaterial.MaterialLevel.ADAPTIVE
        },
        miniBar: {
          miniBarBuilder: () => this.miniBarBuilder(),
          miniBarStyle: 1,
          miniBarWidth: { smallWidth: 200, mediumWidth: 220, largeWidth: 240 },
          enableMiniBarBackground: true,
          enableMiniBarClip: true
        }
      })
      .onChange((index: number) => {
        this.currentTab = index;
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}