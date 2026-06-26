import { catalogueListComponent } from '../view/CatalogueListComponent';
import CatalogueViewModel from '../viewmodel/CatalogueViewModel';
import { HdsNavigation, HdsTabs, HdsTabsController, hdsMaterial } from '@kit.UIDesignKit';
import { CatalogueItemData } from '../viewmodel/CatalogueItemData';

@Entry
@Component
struct Index {
  private controller: HdsTabsController = new HdsTabsController();
  private scroller: Scroller = new Scroller();
  @State currentTab: number = 0;
  @State isMiniBarExpanded: boolean = true;

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
          .fontColor(this.isMiniBarExpanded ? '#000000' : '#FFFFFF')
          .fontWeight(FontWeight.Medium)
        Text('点击展开菜单')
          .fontSize(10)
          .fontColor(this.isMiniBarExpanded ? '#000000' : '#FFFFFF')
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

  build() {
    HdsNavigation() {
      HdsTabs({ controller: this.controller }) {
        TabContent() {
          List({ scroller: this.scroller }) {
            ForEach(CatalogueViewModel.getCatalogueData(), (item: CatalogueItemData) => {
              ListItem() {
                Text(item.title)
                  .fontSize(16)
                  .width('100%')
                  .height(56)
                  .padding({ left: 16 })
              }
            }, (item: CatalogueItemData) => item.id.toString())
          }
          .width('100%')
          .height('100%')
          .clip(false)
          .scrollBar(BarState.Off)
          .backgroundColor($r('sys.color.ohos_id_color_sub_background'))
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
      .layoutWeight(1)
      .width('100%')
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
          onBarStyleChange: (miniBarStyle: number, tabBarStyle: number) => {
            this.isMiniBarExpanded = miniBarStyle === 1;
          },
          enableMiniBarBackground: true,
          enableMiniBarClip: true
        }
      })
      .onChange((index: number) => {
        this.currentTab = index;
      })
    }
    .titleBar({
      content: {
        title: {
          mainTitle: '智慧养老'
        }
      },
      enableComponentSafeArea: true
    })
    .hideBackButton(true)
    .bindToScrollable([this.scroller])
    .height('100%')
    .width('100%')
  }
}
