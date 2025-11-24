class OptionsPage {
    constructor(view, container) {
        this.container = container;
        this.view = view;
    }

    

    createButton(container, name, method) {
        const button = document.createElement("button");
        button.textContent = name;
        button.setAttribute("id", name + "-button");
        button.addEventListener("click", method.bind(this.view));
        container.appendChild(button);
    }

    render() {
        const options_page = document.createElement("div");
        options_page.setAttribute("id", "options-page");
        options_page.classList.add("page");
        this.createTitle(options_page);
        this.createButton(options_page, "Flights", this.view.renderFlightsMenu);
        this.createButton(options_page, "Customers", this.view.renderCustomersMenu);
        this.createButton(options_page, "Staff", this.view.renderStaffMenu);
        this.createButton(options_page, "Aircraft", this.view.renderAircraftMenu);
        this.container.appendChild(options_page);
    }
}

export {OptionsPage}