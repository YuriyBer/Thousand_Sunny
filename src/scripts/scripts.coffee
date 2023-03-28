anchors = document.querySelectorAll(".head__nav__list__item__link")

anchors.forEach((item) ->
  item.addEventListener("click", (e) ->
    e.preventDefault()

    blockId = item.getAttribute("href").substr(1)
    scrollTarget = document.querySelector("#" + blockId)
    topElement = document.querySelector(".head")
    topOffset = topElement.offsetHeight
    elementPosition = scrollTarget.getBoundingClientRect().top
    offsetPosition = elementPosition - topOffset
    window.scrollBy(
      top: offsetPosition,
      behavior: "smooth",
    )
  )
)

entries = document.querySelectorAll(".anchor_target")

options = 
  root: null
  rootMargin: "-49%"
  thereshold: 1


observer = new IntersectionObserver(
  (entries, observer) -> 
    entries.forEach((entry) -> 
      selector = 'a[href="#' + entry.target.id + '"]'
      targetLink = document.querySelector(selector)
      if entry.isIntersecting
        targetLink.classList.add("active_anchor")
      else 
        targetLink.classList.remove("active_anchor")
)
  options
)
entries.forEach((entry) ->
  observer.observe(entry);
)

starRating = document.querySelector(".partner__testimonials__block__grade")
starRating.addEventListener("click", (e) -> 
  if e.target.classList.contains("rating__input")
    console.log e.target.getAttribute("value")
)

getRandomPositionPercentProperty = () -> Math.floor(Math.random() * 100) + "%"

decoContainers = document.querySelectorAll(".deco")

decoContainers.forEach((element) -> 
  decoElem = element.querySelector(".deco_el")
  decoElem.style.top = getRandomPositionPercentProperty()
  decoElem.style.left = getRandomPositionPercentProperty()
)

dropBtn = document.querySelector(".head__nav__menu_btn")
menu = document.querySelector(".head__nav__list")

burgerToggle = (button, menu) ->
  menu.classList.toggle("active")
  button.querySelector(".burger_first").classList.toggle("crossfirst")
  button.querySelector(".burger_second").classList.toggle("crossfirst")
  button.querySelector(".burger_last").classList.toggle("crossback")


dropBtn.addEventListener("click", () -> burgerToggle(dropBtn, menu))

window.addEventListener("click", (e) -> 
  if e.target != dropBtn && document.querySelector(".active")
    burgerToggle(dropBtn, menu);
)

destinationsContainer = document.querySelector('.destination__cards')
destinations = [
  {
    "img": "img/pics/raja_ampat.jpg",
    "country": "Indonesia",
    "place": "Raja Ampat"
  }
  {
    "img": "img/pics/fanjingshan.jpg",
    "country": "China",
    "place": "Fanjingshan"
  }
  {
    "img": "img/pics/vevey.jpg",
    "country": "Switzerland",
    "place": "Vevey"
  }
  {
    "img": "img/pics/skadar.jpg",
    "country": "Montenegro",
    "place": "Skadar"
  }
]

destinations.forEach((item) ->
  htmlCard = document.createElement("figure")
  htmlCard.classList.add("destination__cards__card")
  htmlCard.innerHTML = """
  <img class="destination__cards__card__img" src=#{item.img} alt=#{item.place}>
    <figcaption class="destination__cards__card__caption">
        <h3 class="destination__cards__card__caption__place"> #{item.place} </h3>
        <p class="destination__cards__card__caption__country"> #{item.country} </p>
    </figcaption>
    """
  destinationsContainer.appendChild(htmlCard)
)

storiesBlock = document.querySelector('.stories__block')
stories = [
  {
    "img": "img/pics/image12.jpg"
    "title": "The many benefits of taking a healing holiday"
    "description": "‘Helaing holidays’ are on the rise tohelp maximise your health and happines..."
  }
  {
    "img": "img/pics/image13.jpg"
    "title": "The best Kyoto restaurant to try Japanese food"
    "description": "From tofu to teahouses, here’s our guide to Kyoto’s best restaurants to visit..."
  }
  {
    "img": "img/pics/image14.jpg"
    "title": "Skip Chichen Itza and head to this remote Yucatan"
    "description": "It’s remote and challenging to get, but braving the jungle and exploring these ruins without the..."
  }
  {
    "img": "img/pics/image15.jpg"
    "title": "Surf’s up at these beginner spots around the world"
    "description": "If learning to surf has in on your to-do list for a while, the good news is: it’s never too late..."
  }
]

stories.forEach((item) ->
  htmlCard = document.createElement("figure")
  htmlCard.classList.add("stories__block__story")
  htmlCard.innerHTML = """
  <div class="stories__block__story__image">
  <img class="stories__block__story__image__img" src=#{item.img} alt=#{item.title}>
  </div>
    <figcaption class="stories__block__story__caption">
        <h3 class="stories__block__story__caption__title"> #{item.title} </h3>
        <p class="stories__block__story__caption__description"> #{item.description} </p>
        <a class="stories__block__story__caption__link orange_link" href=""> Read more</a>
    </figcaption>
    """
  storiesBlock.appendChild(htmlCard)
)

partnerPhoto = document.querySelector('.partner__testimonials__reviewer__photo')
partnerArrowBackward = document.querySelector('.partner__testimonials__reviewer__control__arrow_backward')
partnerArrowForward = document.querySelector('.partner__testimonials__reviewer__control__arrow_forward')
partnerPhotos = [
  "img/pics/image_6.jpg",
  "img/pics/image_7.jpg",
  "img/pics/image_8.jpg"
]
photo = 0
showSlides = (photo) ->
    if photo == partnerPhotos.length - 1
      partnerArrowForward.classList.remove('control_active')
      partnerArrowForward.disabled = true
    else if photo == 0
      partnerArrowBackward.classList.remove('control_active')
      partnerArrowBackward.disabled = true
    if photo > 0
      partnerArrowBackward.disabled = false
      partnerArrowBackward.classList.add('control_active')
    if photo < partnerPhotos.length - 1
      partnerArrowForward.classList.add('control_active')
      partnerArrowForward.disabled = false
    partnerPhoto.src = partnerPhotos[photo]
showSlides(photo)
partnerArrowBackward.addEventListener("click", () ->
  showSlides(--photo)
)
partnerArrowForward.addEventListener("click", () ->
  showSlides(++photo)
)