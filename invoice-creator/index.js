let services = []
const washCar = {service : "Wash car",
                price : 10
            }
const mowLawn = {service : "Mow lawn",
            price : 20
        } 
const pullWeed = {service: " Pull weeds",
                 price : 30
                }           
let washBtn = document.getElementById("wash-btn")
let mowBtn = document.getElementById("mow-btn")
let weedBtn = document.getElementById("weed-btn")
let totalBtn = document.getElementById("total-btn")
let ulEl = document.getElementById("ul-el")
let total = document.getElementById("total")
let sendInvoice = document.getElementById("invoice")
let sum = 0
function render(){
    let work = ""
    for(let i = 0; i < services.length; i++){
        
        work += ` <div class ="action">
        <p>${services[i].service}</p> 
        <p class ="price">\$${services[i].price}</p>
        </div>`
    }
    ulEl.innerHTML = work
}
washBtn.addEventListener("click", function(){
    services.push(washCar)
    render()
    sum =sum + washCar.price
    total.textContent = ` \$${sum}`
    console.log("hello")
})
mowBtn.addEventListener("click", function(){
    services.push(mowLawn)
    render()
    sum = sum + mowLawn.price
    total.textContent = ` \$${sum}`
})
weedBtn.addEventListener("click", function(){
    services.push(pullWeed)
    render()
    sum =sum + pullWeed.price
    total.textContent = `
      \$${sum}
      `
})
sendInvoice.addEventListener("click", function(){
  services = [] 
  render() 
  sum = 0;
  total.textContent = `\$ ${sum}`
})
console.log(services)