import 'package:example/section_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hover_effects/flutter_hover_effects.dart';

class ShowcaseScreen extends StatelessWidget {
  const ShowcaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F0),
      appBar: AppBar(
        title: const Text('Hover Effects Showcase'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: const Color(0xFF444444),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionWidget(
                  title: 'Holographic Card',
                  child: _buildHolographicCard(),
                ),

                _buildSectionTitle(context, 'Scotch Tape Product Showcase'),
                const SizedBox(height: 16),
                _buildScotchShowcase(),
                const SizedBox(height: 48),
                _buildSectionTitle(context, 'Paper Card Grid'),
                const SizedBox(height: 16),
                _buildPaperCardGrid(),
                const SizedBox(height: 48),
                _buildSectionTitle(context, 'Cursor Animations'),
                const SizedBox(height: 16),
                _buildCursorAnimations(),
                const SizedBox(height: 48),
                _buildSectionTitle(context, 'Hover Underline'),
                const SizedBox(height: 16),
                _buildHoverUnderline(),
                const SizedBox(height: 48),
                _buildSectionTitle(context, 'Animated Navigation Menus'),
                const SizedBox(height: 16),
                _buildNavMenus(),
                const SizedBox(height: 48),
                _buildSectionTitle(context, '3D Buttons'),
                const SizedBox(height: 16),
                _build3DButtons(),
                const SizedBox(height: 48),

                const SizedBox(height: 48),
                _buildSectionTitle(context, '3D Flip Card'),
                const SizedBox(height: 16),
                _buildFlipCard(),
                const SizedBox(height: 48),
                _buildSectionTitle(context, 'Liquid Morph Effect'),
                const SizedBox(height: 16),
                _buildLiquidMorphEffect(),
                const SizedBox(height: 48),
                _buildSectionTitle(context, 'Animated Arrow Button'),
                const SizedBox(height: 16),
                _buildAnimatedArrowButton(),
                const SizedBox(height: 48),
                _buildSectionTitle(context, '3D Rotating Cube'),
                const SizedBox(height: 16),
                _buildRotatingCube(),
                const SizedBox(height: 48),
                _buildSectionTitle(context, 'Card Slide Effect'),
                const SizedBox(height: 16),
                _buildCardSlide(),
                const SizedBox(height: 48),
                _buildSectionTitle(context, 'Card Face Effect'),
                const SizedBox(height: 16),
                _buildCardFace(),
                const SizedBox(height: 48),
                _buildSectionTitle(context, 'Card Skew Effect'),
                const SizedBox(height: 16),
                _buildCardSkew(),
                const SizedBox(height: 48),
                _buildSectionTitle(context, 'Card Hover Effect'),
                const SizedBox(height: 16),
                _buildCardHover(),
                const SizedBox(height: 48),
                _buildSectionTitle(context, 'Social Media Icons'),
                const SizedBox(height: 16),
                _buildSocialIcons(),
                const SizedBox(height: 48),
                _buildSectionTitle(context, 'Animated Play Button'),
                const SizedBox(height: 16),
                _buildAnimatedPlayButton(),
                const SizedBox(height: 48),
                _buildSectionTitle(context, 'Animated Icons'),
                const SizedBox(height: 16),
                _buildAnimatedIcons(),
                const SizedBox(height: 48),
                _buildSectionTitle(context, '3D Social Media Buttons'),
                const SizedBox(height: 16),
                _build3DSocialButtons(),
                const SizedBox(height: 48),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(
        context,
      ).textTheme.headlineSmall?.copyWith(color: const Color(0xFF444444)),
    );
  }

  Widget _buildScotchShowcase() {
    return Center(
      child: ScotchShowcase(
        onBuyNow: () {},
        onLearnMore: () {},
        // For web, you might use NetworkImage for noise/gif.
        // For other platforms, consider AssetImage.
        // noiseTexture: NetworkImage('https://i.gyazo.com/a26366e538851a5c569ff648e99b7fd4.png'),
        // hoverOverlay: Image.network('https://64.media.tumblr.com/da60c13b478dda09ab90c27e880983b8/tumblr_nd4pwdPKdc1tun3l0o1_1280.gif', fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildPaperCardGrid() {
    Widget cardContent({required String imageUrl, required String title}) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.network(imageUrl, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      );
    }

    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        SizedBox(
          width: 250,
          child: PaperCard(
            child: cardContent(
              imageUrl:
                  'https://cdn.sanity.io/images/34ent8ly/production/f31810d13e2e27f7f502218b8f4f28e0008e1ed7-3000x3000.png?w=640&q=75',
              title: 'Remix: a practical guide',
            ),
          ),
        ),
        SizedBox(
          width: 250,
          child: PaperCard(
            child: cardContent(
              imageUrl:
                  'https://cdn.sanity.io/images/34ent8ly/production/adffce6e572b1e67f8301c0cd45ea0019a9e0be8-4167x4167.png?w=640&q=75',
              title: 'Nuxt: a practical guide',
            ),
          ),
        ),
        SizedBox(
          width: 250,
          child: PaperCard(
            child: cardContent(
              imageUrl:
                  'https://cdn.sanity.io/images/34ent8ly/production/69cca46986d67b738f488daf17ac61a9f8f00068-3000x3000.png?w=640&q=75',
              title: 'Solid: a practical guide',
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCursorAnimations() {
    const textStyle = TextStyle(color: Colors.white);
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      alignment: WrapAlignment.center,
      children: const [
        CursorShowcaseBox(
          cursor: SystemMouseCursors.click,
          child: Text('pointer', style: textStyle),
        ),
        CursorShowcaseBox(
          cursor: SystemMouseCursors.help,
          child: Text('help', style: textStyle),
        ),
        CursorShowcaseBox(
          cursor: SystemMouseCursors.wait,
          child: Text('wait', style: textStyle),
        ),
        CursorShowcaseBox(
          cursor: SystemMouseCursors.text,
          child: Text('text', style: textStyle),
        ),
        CursorShowcaseBox(
          cursor: SystemMouseCursors.forbidden,
          child: Text('not-allowed', style: textStyle),
        ),
        CursorShowcaseBox(
          cursor: SystemMouseCursors.grab,
          child: Text('grab', style: textStyle),
        ),
        CursorShowcaseBox(
          cursor: SystemMouseCursors.zoomIn,
          child: Text('zoom-in', style: textStyle),
        ),
        CursorShowcaseBox(
          cursor: SystemMouseCursors.copy,
          child: Text('copy', style: textStyle),
        ),
        CursorShowcaseBox(
          cursor: SystemMouseCursors.move,
          child: Text('move', style: textStyle),
        ),
        CursorShowcaseBox(
          cursor: SystemMouseCursors.alias,
          child: Text('alias', style: textStyle),
        ),
      ],
    );
  }

  Widget _buildHoverUnderline() {
    return const Center(
      child: HoverUnderline(
        text: 'Reza Taghizadeh',
        theme: HoverUnderlineTheme(
          lineGap: 0,
          lineHeight: 4,
          textStyle: TextStyle(
            fontSize: 32,
            height: 0,
            color: Color(0xFF444444),
          ),
        ),
      ),
    );
  }

  Widget _buildNavMenus() {
    return Wrap(
      spacing: 48,
      runSpacing: 48,
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        AnimatedNavMenu(
          items: [
            AnimatedNavMenuItem(
              icon: Icons.home_outlined,
              title: 'Home',
              hoverGradient: const LinearGradient(
                colors: [Color(0xFFa955ff), Color(0xFFea51ff)],
              ),
              onTap: () {},
            ),
            AnimatedNavMenuItem(
              icon: Icons.videocam_outlined,
              title: 'Video',
              hoverGradient: const LinearGradient(
                colors: [Color(0xFF56CCF2), Color(0xFF2F80ED)],
              ),
              onTap: () {},
            ),
            AnimatedNavMenuItem(
              icon: Icons.camera_alt_outlined,
              title: 'Photo',
              hoverGradient: const LinearGradient(
                colors: [Color(0xFFFF9966), Color(0xFFFF5E62)],
              ),
              onTap: () {},
            ),
          ],
        ),
        SlidingNavMenu(
          items: [
            SlidingNavMenuItem(
              title: 'Home',
              onTap: () {},
              highlightColor: const Color(0xFF3498db),
            ),
            SlidingNavMenuItem(
              title: 'About',
              onTap: () {},
              highlightColor: const Color(0xFFffd071),
            ),
            SlidingNavMenuItem(
              title: 'Work',
              onTap: () {},
              highlightColor: const Color(0xFFf0776c),
            ),
            SlidingNavMenuItem(
              title: 'Contact',
              onTap: () {},
              highlightColor: const Color(0xFF1abc9c),
            ),
          ],
        ),
        AnimatedUnderlineNav(
          items: [
            AnimatedUnderlineNavItem(title: 'Home', onTap: () {}),
            AnimatedUnderlineNavItem(title: 'About', onTap: () {}),
            AnimatedUnderlineNavItem(title: 'Contact', onTap: () {}),
          ],
        ),
      ],
    );
  }

  Widget _build3DButtons() {
    return Wrap(
      spacing: 32,
      runSpacing: 16,
      alignment: WrapAlignment.center,
      children: [
        Button3D(onPressed: () {}, width: 150, child: const Text("don't")),
        Button3D(onPressed: () {}, width: 150, child: const Text("push")),
        Button3D(onPressed: () {}, width: 150, child: const Text("me")),
      ],
    );
  }

  Widget _buildHolographicCard() {
    return const Center(child: HolographicCard(child: Text('HOLOGRAM')));
  }

  Widget _buildFlipCard() {
    return Center(
      child: FlipCard(
        front: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          alignment: Alignment.center,
          child: const Text('Front Side', style: TextStyle(fontSize: 20)),
        ),
        back: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: const Color(0xFF8b5cf6),
          ),
          alignment: Alignment.center,
          child: const Text(
            'Back Side',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildLiquidMorphEffect() {
    return const Center(child: LiquidMorph(child: Text('TRANSFORM')));
  }

  Widget _buildAnimatedArrowButton() {
    return Center(
      child: AnimatedArrowButton(onPressed: () {}, child: const Text('NEXT')),
    );
  }

  Widget _buildRotatingCube() {
    return const Center(
      child: SizedBox(
        width: 250,
        height: 250,
        child: RotatingCube(
          frontFace: Text('Front'),
          backFace: Text('Back'),
          topFace: Text('Top'),
          bottomFace: Text('Bottom'),
          leftFace: Text('Left'),
          rightFace: Text('Right'),
        ),
      ),
    );
  }

  Widget _buildCardSlide() {
    return Center(
      child: CardSlide(
        topSlide: Container(
          color: const Color(0xFF2c73df),
          child: const Center(
            child: Icon(Icons.account_circle, size: 80, color: Colors.white),
          ),
        ),
        bottomSlide: Container(
          color: Colors.white,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Hello there!",
                style: TextStyle(fontSize: 24, color: Color(0xFF414141)),
              ),
              SizedBox(height: 8),
              Text(
                "Trust yourself and keep going.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xFF414141)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardFace() {
    const textStyle = TextStyle(fontSize: 16, color: Colors.black87);
    const titleStyle = TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );

    return Wrap(
      spacing: 20,
      runSpacing: 20,
      alignment: WrapAlignment.center,
      children: [
        CardFace(
          topFaceDecoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF3503ad), Color(0xFFf7308c)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          topFace: const Text(
            '01',
            style: TextStyle(
              fontSize: 60,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          bottomFace: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Lorem Ipsum', style: titleStyle),
              SizedBox(height: 8),
              Text(
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                textAlign: TextAlign.center,
                style: textStyle,
              ),
            ],
          ),
        ),
        CardFace(
          topFaceDecoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFccff00), Color(0xFF09afff)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          topFace: const Text(
            '02',
            style: TextStyle(
              fontSize: 60,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          bottomFace: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Lorem Ipsum', style: titleStyle),
              SizedBox(height: 8),
              Text(
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                textAlign: TextAlign.center,
                style: textStyle,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCardSkew() {
    const content = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Card One',
          style: TextStyle(
            fontSize: 28,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
        SizedBox(height: 10),
        Text(
          'Read More',
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
            backgroundColor: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );

    return const Wrap(
      spacing: 30,
      runSpacing: 40,
      alignment: WrapAlignment.center,
      children: [
        CardSkew(gradientIndex: 0, child: content),
        CardSkew(gradientIndex: 1, child: content),
        CardSkew(gradientIndex: 2, child: content),
      ],
    );
  }

  Widget _buildCardHover() {
    return Wrap(
      spacing: 25,
      runSpacing: 25,
      alignment: WrapAlignment.center,
      children: [
        CardHover(
          image: const NetworkImage(
            'https://images.pexels.com/photos/45202/brownie-dessert-cake-sweet-45202.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260',
          ),
          category: 'Recipe',
          title: 'Crisp Spanish tortilla Matzo brei',
          author: 'Celeste Mills',
          onAuthorTap: () {},
        ),
        CardHover(
          image: const NetworkImage(
            'https://images.pexels.com/photos/307008/pexels-photo-307008.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260',
          ),
          category: 'Travel',
          title: 'Discover the sea',
          author: 'John Doe',
          onAuthorTap: () {},
        ),
      ],
    );
  }

  Widget _buildSocialIcons() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      alignment: WrapAlignment.center,
      children: [
        SocialIconButton(
          icon: const IconData(0xf09a, fontFamily: 'FontAwesome'),
          onPressed: () {},
          theme: const SocialIconButtonTheme(hoverFillColor: Color(0xFF3b5999)),
        ),
        SocialIconButton(
          icon: const IconData(0xf099, fontFamily: 'FontAwesome'),
          onPressed: () {},
          theme: const SocialIconButtonTheme(hoverFillColor: Color(0xFF55acee)),
        ),
        SocialIconButton(
          icon: const IconData(0xf0e1, fontFamily: 'FontAwesome'),
          onPressed: () {},
          theme: const SocialIconButtonTheme(hoverFillColor: Color(0xFF0077b5)),
        ),
        SocialIconButton(
          icon: const IconData(0xf0d5, fontFamily: 'FontAwesome'),
          onPressed: () {},
          theme: const SocialIconButtonTheme(hoverFillColor: Color(0xFFdd4b39)),
        ),
      ],
    );
  }

  Widget _buildAnimatedPlayButton() {
    return Center(child: AnimatedPlayButton(onPressed: () {}));
  }

  Widget _buildAnimatedIcons() {
    return const Wrap(
      spacing: 10,
      runSpacing: 10,
      alignment: WrapAlignment.center,
      children: [
        AnimatedIconWidget(icon: Icons.calculate),
        AnimatedIconWidget(icon: Icons.directions_car),
        AnimatedIconWidget(icon: Icons.coffee),
        AnimatedIconWidget(icon: Icons.thumb_up_alt_outlined),
      ],
    );
  }

  Widget _build3DSocialButtons() {
    const textStyle = TextStyle(
      color: Color(0xFF262626),
      letterSpacing: 4,
      fontSize: 16,
    );
    return Wrap(
      spacing: 5,
      runSpacing: 50,
      alignment: WrapAlignment.center,
      children: [
        Button3DSocial(
          onPressed: () {},
          theme: const Button3DSocialTheme(
            hoverBackgroundColor: Color(0xFF3b5998),
            hoverSideColor: Color(0xFF365492),
            hoverBottomColor: Color(0xFF4a69ad),
          ),
          child: const Row(
            children: [
              Icon(
                IconData(0xf09a, fontFamily: 'FontAwesome'),
                size: 40,
                color: Color(0xFF262626),
              ),
              SizedBox(width: 14),
              Text(' - Facebook', style: textStyle),
            ],
          ),
        ),
        Button3DSocial(
          onPressed: () {},
          theme: const Button3DSocialTheme(
            hoverBackgroundColor: Color(0xFF00aced),
            hoverSideColor: Color(0xFF097aa5),
            hoverBottomColor: Color(0xFF53b9e0),
          ),
          child: const Row(
            children: [
              Icon(
                IconData(0xf099, fontFamily: 'FontAwesome'),
                size: 40,
                color: Color(0xFF262626),
              ),
              SizedBox(width: 14),
              Text(' - Twitter', style: textStyle),
            ],
          ),
        ),
      ],
    );
  }
}
