# BossTransitionAnim
仿写Boss直聘的转场动画

在iOS7之后，开发者可以自定制转场动画，但是本人在开发过程中一直要兼容iOS6，因此也没能在项目中使用到这些新特性，本文旨在学习，参考资料在文末给出。以下下指示谈谈仿写中的一些思路和误区。

### 思路一
 `push`动画分为两部分：
 
 1. `push`开始时先进行的是 fromVC.view 的缩放动画，并且显示一个遮罩层覆盖掉你所点击的位置(例如:`cell`,demo中用Button代替)
 2. 紧接着将遮罩层进行放大到遮挡住整个屏幕，完成后移除掉次遮罩层
 
### 思路二
 
 `pop`有两个动画效果:一个是通过`tableView`滑动到一定位置时开始`pop`的转场动画，一个是直接点击`navigatioBar`上的返回按钮进行的界面下滑出屏幕的`pop`转场动画。因此我增加了一个 `BOOL` 值来判断是哪种动画。
 
 对第二种动画下过很容易就能做到，但是对于第一种动画效果，本人计入了一个误区。
 
### 误区
 
 做第一种`pop`动画时，一开始以为是按照滑动距离来进行类似于进行手势百分比返回的转场动画，但是当我进行实际编码是发现如果是按百分比进行动画，无论我怎么写都会出现 BUG 并且达不到我想要的效果，因此在深(shui)思(jiao)后，还是采用了如 `push`动画一样的截图来实现(如果你能实现百分比返回，请收下我的膝盖并告诉我🙃)
 
 
### 参考链接
1. [OneV's Den 博客 - iOS7中的ViewController切换 OneV's Den](https://onevcat.com/2013/10/vc-transition-in-ios7/)
2. [ColinEberhardt的VCTransitionsLibrary](https://github.com/ColinEberhardt/VCTransitionsLibrary)
3. [Kitten's 时间胶囊 - 实现Keynote中的神奇移动效果](http://kittenyang.com/magicmove/)
