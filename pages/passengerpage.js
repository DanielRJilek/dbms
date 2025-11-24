class PassengerPage {
    constructor(view, container) {
        this.container = container;
        this.view = view;
        let mysql = require('mysql');
        let connection = mysql.createConnection();
    }

    createButton(container, name, method) {
        const button = document.createElement("button");
        button.textContent = name;
        button.setAttribute("id", name + "-button");
        button.addEventListener("click", method.bind(this.view));
        container.appendChild(button);
    }

    render() {
        const passenger_page = document.createElement("div");
        passenger_page.setAttribute("id", "passenger-page");
        passenger_page.classList.add("page");
        this.createButton(passenger_page, "Create Passenger", this.view.renderFlightsMenu);
        this.container.appendChild(title_page);
    }

}

export {PassengerPage}