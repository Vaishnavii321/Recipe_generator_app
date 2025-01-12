class OnboardingContent {
  String image;
  String title;
  String discription;

  OnboardingContent({
    required this.image,
    required this.title,
    required this.discription,
  });
}

List<OnboardingContent> contents = [

  OnboardingContent(
    image: 'assets/images/page1.png',
    title: 'Discover Recipes',
    discription: 'Unlock a world of flavors! Find recipes tailored to your taste buds and create culinary masterpieces effortlessly.',
  ),
  OnboardingContent(
    image: 'assets/images/page2.png',
    title: 'Personalize Your Diet',
    discription: "Your diet is in your hands. Customize each recipe to suit your dietary preferences, allergies, and nutrition goals.",
  ),
  OnboardingContent(
    image: 'assets/images/page3.png',
    title: 'Start Cooking!',
    discription: 'Ready, set, cook! Follow step-by-step guides and transform fresh ingredients into mouthwatering dishes, perfect for any occasion.',
  ),
];
