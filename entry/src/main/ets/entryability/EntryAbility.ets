import { AbilityConstant, UIAbility, Want } from '@kit.AbilityKit';
import { promptAction, window } from '@kit.ArkUI';
import CommonValues from '../pages/commons/CommonValues';
import Logger from '../utils/Logger';

export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {


    Logger.info('lsyyy', 'Ability onCreate')


    this.context.eventHub.on(CommonValues.LOCAL_PAGE, () => {
      promptAction.showToast({
        message: "eventHub LOCAL_PAGEadsdsd"
      })
      let want: Want = {
        bundleName: 'com.example.wanharmony',
        moduleName: 'entry',
        abilityName: 'EntryPictureAbility'
      }
      this.context.startAbility(want)

    })

  }

  onDestroy(): void {
    Logger.info('lsyyy', 'Ability onDestroy');
    getContext().eventHub.off(CommonValues.LOCAL_PAGE)
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    // Main window is created, set main page for this ability
    Logger.info('lsyyy', 'Ability onWindowStageCreate');

    windowStage.loadContent('pages/Index', (err) => {
      // windowStage.loadContent('pages/commons/PageDemoMeasure', (err) => {
      if (err.code) {
        Logger.error('lsyyy', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      Logger.info('lsyyy', 'Succeeded in loading the content.');
    });
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    Logger.info('lsyyy', 'Ability onWindowStageDestroy');
  }

  onForeground(): void {
    // Ability has brought to foreground
    Logger.info('lsyyy', 'Ability onForeground');
  }

  onBackground(): void {
    // Ability has back to background
    Logger.info('lsyyy', 'Ability onBackground');
  }
}
