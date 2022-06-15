import Flatpickr from 'stimulus-flatpickr'
import rangePlugin from 'flatpickr/dist/plugins/rangePlugin.js'

export default class extends Flatpickr {

    connect(){
        this.config = {
            altInput: true,
            showMonths: 1,
            altFormat: "j.m.Y H:i",
            dateFormat: "Y-m-d H:i",
            minTime: "00:00",
            maxTime: "00:00",
            enableTime: true,
            inline: true,
            allowInput: true,
            mode: 'range',
            "plugins": [new rangePlugin({ input: "#reservation_end_date"})]
        }
        super.connect()
    }

    change(selectedDates, dateStr, instance) {
        const startDate = selectedDates[0]
        const endDate = selectedDates[1]
        let count_days = ((endDate - startDate) / (1000 * 3600 * 24)) + 1
        let arrSelectedDates = this.getDatesBetweenDates(startDate, endDate)
        const strArrDisabledDates = instance.element.dataset.flatpickrDisable
        const costs = document.querySelector('.costs')
        const arrSelectedDatesStr = arrSelectedDates.map( date => date.toLocaleDateString('en-ca'))

        arrSelectedDatesStr.map(date => {
            if (strArrDisabledDates.includes(date)) {
                costs.classList.remove('is-visible')
                alert(`${date} not available. The booking range must not include unavailable days.`)
                instance.clear()
            }
        })

        if (count_days) {
            this.updateCosts(count_days)
            costs.classList.add('is-visible')
        }
    }

    getDatesBetweenDates(startDate, endDate) {
        let dates = []
        const theDate = new Date(startDate)
        while (theDate < endDate) {
            dates = [...dates, new Date(theDate)]
            theDate.setDate(theDate.getDate() + 1)
        }
        dates = [...dates, endDate]
        return dates
    }

    updateCosts(count_days) {
        const costs = document.querySelector('.costs')

        if (!costs) return
        let daysElem = document.getElementById('days')
            let priceElem = document.getElementById('usage_fee')
            let discountElem = document.getElementById('discount')
            let totalPriceElem = document.getElementById('total-price')

            let usageFee = JSON.parse(costs.dataset.rate)
            let discount = Number(discountElem.innerText)
            let price = count_days * usageFee
            let totalPrice = price * (100 - discount)/100

            daysElem.innerHTML = count_days
            priceElem.innerHTML = price.toFixed(2)
            totalPriceElem.innerHTML = totalPrice.toFixed(2)
    }
}
